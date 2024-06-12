import 'package:obfuscation_controller/app/domain/editor/enum/line_type.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_console_line_model.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_editor_line_model.dart';
import 'package:obfuscation_controller/config/app_strings.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';

class EditorComparisonDomainLayerService {
  OperationResult<(List<AdvancedEditorLineModel>, List<AdvancedEditorLineModel>, List<AdvancedConsoleLineModel>)> compareFiles({
    required String filePath,
    required List<String> fileLines,
    required String folderPath,
    required List<String> folderContents,
  }) {
    fileLines = fileLines.map((e) => e.trim()).toList();
    folderContents.sort((a, b) => a.toString().toLowerCase().compareTo(b.toString().toLowerCase()));

    final (List<AdvancedEditorLineModel>, List<AdvancedConsoleLineModel>) obfuscationResults = _processFileLines(
      filePath: filePath,
      folderPath: folderPath,
      fileLines: fileLines,
      folderContents: folderContents,
    );

    final (List<AdvancedEditorLineModel>, List<AdvancedConsoleLineModel>) dependencyResults = _processFolderContents(
      filePath: filePath,
      folderPath: folderPath,
      fileLines: fileLines,
      folderContents: folderContents,
    );

    List<AdvancedConsoleLineModel> consoleLines = [...obfuscationResults.$2, ...dependencyResults.$2];

    _sortAdvancedConsoleLineModels(consoleLines: consoleLines);

    return OperationResult(
      data: (obfuscationResults.$1, dependencyResults.$1, consoleLines),
      failure: null,
    );
  }

  (List<AdvancedEditorLineModel>, List<AdvancedConsoleLineModel>) _processFileLines({
    required String filePath,
    required String folderPath,
    required List<String> fileLines,
    required List<String> folderContents,
  }) {
    final List<AdvancedEditorLineModel> obfuscationLines = [];
    final List<AdvancedConsoleLineModel> consoleLines = [];

    int lineIndex = 1;
    for (String fileLine in fileLines) {
      if (!fileLine.contains(AppStrings.obfuscationRelatedLine)) {
        obfuscationLines.add(
          AdvancedEditorLineModel(
            filePath: filePath,
            lineNumber: lineIndex,
            line: fileLine,
            lineType: LineType.normal,
          ),
        );
      } else if (_isLineLegitAndHavingTheSameDependencyNameAndVersion(obfuscationLine: fileLine, dependencyLines: folderContents)) {
        obfuscationLines.add(
          AdvancedEditorLineModel(
            filePath: filePath,
            lineNumber: lineIndex,
            line: fileLine,
            lineType: LineType.success,
          ),
        );
      } else {
        obfuscationLines.add(
          AdvancedEditorLineModel(
            filePath: filePath,
            lineNumber: lineIndex,
            line: fileLine,
            lineType: LineType.warning,
          ),
        );

        final dependency = _isContainingTheSameDependencyName(obfuscationLine: fileLine, dependencyLines: folderContents);

        consoleLines.add(
          AdvancedConsoleLineModel(
            obfuscationFileLine: _extractDependencyNameAndVersionFromObfuscationLine(obfuscationLine: fileLine),
            dependencyFolderLine: dependency?.$1,
            obfuscationLineNumber: lineIndex,
            dependencyLineNumber: dependency?.$2,
            errorTextType: dependency == null ? TextType.obfuscationFileNeverUsed : TextType.differencesDetected,
            lineType: LineType.warning,
          ),
        );
      }

      lineIndex++;
    }

    return (obfuscationLines, consoleLines);
  }

  (List<AdvancedEditorLineModel>, List<AdvancedConsoleLineModel>) _processFolderContents({
    required String filePath,
    required String folderPath,
    required List<String> fileLines,
    required List<String> folderContents,
  }) {
    final List<AdvancedEditorLineModel> dependencyLines = [];
    final List<AdvancedConsoleLineModel> consoleLines = [];

    int lineIndex = 1;
    for (String folderLine in folderContents) {
      final bool hasDependencyNameAndVersionUsedObfuscationFile = _hasDependencyNameAndVersionUsedObfuscationFile(dependency: folderLine, obfuscationLines: fileLines);

      if (hasDependencyNameAndVersionUsedObfuscationFile) {
        dependencyLines.add(
          AdvancedEditorLineModel(
            filePath: folderPath,
            lineNumber: lineIndex,
            line: folderLine,
            lineType: LineType.success,
          ),
        );
      } else {
        dependencyLines.add(
          AdvancedEditorLineModel(
            filePath: folderPath,
            lineNumber: lineIndex,
            line: folderLine,
            lineType: LineType.warning,
          ),
        );

        final bool hasDependencyNameUsedObfuscationFile = _hasDependencyNameUsedObfuscationFile(dependency: folderLine, obfuscationLines: fileLines);

        if (!hasDependencyNameUsedObfuscationFile) {
          consoleLines.add(
            AdvancedConsoleLineModel(
              obfuscationFileLine: null,
              dependencyFolderLine: folderLine,
              obfuscationLineNumber: null,
              dependencyLineNumber: lineIndex,
              errorTextType: TextType.dependencyNeverUsed,
              lineType: LineType.warning,
            ),
          );
        }
      }

      lineIndex++;
    }

    return (dependencyLines, consoleLines);
  }

  bool _isLineLegitAndHavingTheSameDependencyNameAndVersion({required String obfuscationLine, required List<String> dependencyLines}) {
    try {
      final obfuscationLineDependency = obfuscationLine.substring(obfuscationLine.lastIndexOf('/') + 1, obfuscationLine.lastIndexOf('"'));
      final dependencyLineIndex = dependencyLines.indexOf(obfuscationLineDependency);

      if (dependencyLineIndex == -1) {
        return false;
      }

      return obfuscationLine == '+"${AppStrings.obfuscationRelatedLine}$obfuscationLineDependency"' || obfuscationLine == '-"${AppStrings.obfuscationRelatedLine}$obfuscationLineDependency"';
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.stringOperationError,
        exception: ex,
      );
    }

    return false;
  }

  (String, int)? _isContainingTheSameDependencyName({required String obfuscationLine, required List<String> dependencyLines}) {
    if (!obfuscationLine.contains(AppStrings.obfuscationRelatedLine)) {
      return null;
    }

    try {
      final String obfuscationLineDependency = _extractDependencyNameFromObfuscationLine(obfuscationLine: obfuscationLine);
      final int dependencyLineIndex = dependencyLines.indexWhere((line) => line.startsWith('$obfuscationLineDependency-'));

      if (dependencyLineIndex != -1) {
        final String dependency = dependencyLines[dependencyLineIndex];
        return (dependency, dependencyLineIndex + 1);
      }

      return null;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.stringOperationError,
        exception: ex,
      );
    }

    return null;
  }

  bool _hasDependencyNameAndVersionUsedObfuscationFile({required String dependency, required List<String> obfuscationLines}) {
    try {
      final int obfuscationLineIndex = obfuscationLines.indexWhere((line) => line.contains(dependency));
      return obfuscationLineIndex != -1;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.stringOperationError,
        exception: ex,
      );
    }

    return false;
  }

  bool _hasDependencyNameUsedObfuscationFile({required String dependency, required List<String> obfuscationLines}) {
    try {
      final String dependencyName = _extractDependencyNameFromDependencyFolder(dependencyLine: dependency);
      final int obfuscationLineIndex = obfuscationLines.indexWhere((line) => line.contains(dependencyName));
      return obfuscationLineIndex != -1;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.stringOperationError,
        exception: ex,
      );
    }

    return false;
  }

  String _extractDependencyNameFromDependencyFolder({required String dependencyLine}) {
    try {
      return dependencyLine.substring(0, dependencyLine.lastIndexOf('-'));
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.stringOperationError,
        exception: ex,
      );
    }

    return dependencyLine;
  }

  String _extractDependencyNameFromObfuscationLine({required String obfuscationLine}) {
    try {
      return obfuscationLine.substring(obfuscationLine.lastIndexOf('/') + 1, obfuscationLine.lastIndexOf('-'));
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.stringOperationError,
        exception: ex,
      );
    }

    return obfuscationLine;
  }

  String _extractDependencyNameAndVersionFromObfuscationLine({required String obfuscationLine}) {
    try {
      return obfuscationLine.substring(obfuscationLine.lastIndexOf('/') + 1, obfuscationLine.lastIndexOf('"'));
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.stringOperationError,
        exception: ex,
      );
    }

    return obfuscationLine;
  }
}

void _sortAdvancedConsoleLineModels({required List<AdvancedConsoleLineModel> consoleLines}) {
  consoleLines.sort((a, b) {
    final aMin = (a.obfuscationLineNumber ?? a.dependencyLineNumber) ?? 0;
    final bMin = (b.obfuscationLineNumber ?? b.dependencyLineNumber) ?? 0;
    return aMin.compareTo(bMin);
  });
}
