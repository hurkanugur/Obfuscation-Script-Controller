import 'package:obfuscation_controller/app/domain/file/enum/line_type.dart';
import 'package:obfuscation_controller/app/domain/file/model/advanced_line_model.dart';
import 'package:obfuscation_controller/config/app_strings.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';

class FileComparisonDomainLayerService {
  OperationResult<Map<String, List<AdvancedLineModel>>> compareFiles({
    required String filePath,
    required List<String> fileLines,
    required String folderPath,
    required List<String> folderContents,
  }) {
    final List<AdvancedLineModel> processedFileLines = _processFileLines(
      filePath: filePath,
      fileLines: fileLines,
      folderContents: folderContents,
    );

    final List<AdvancedLineModel> processedFolderContents = _processFolderContents(
      folderPath: folderPath,
      fileLines: fileLines,
      folderContents: folderContents,
    );

    return OperationResult(
      data: {
        filePath: processedFileLines,
        folderPath: processedFolderContents,
      },
      failures: null,
    );
  }

  List<AdvancedLineModel> _processFileLines({
    required String filePath,
    required List<String> fileLines,
    required List<String> folderContents,
  }) {
    final List<AdvancedLineModel> smartFileLines = [];
    int lineIndex = 1;

    for (String fileLine in fileLines) {
      if (!fileLine.contains(AppStrings.dependencyRelatedLine)) {
        smartFileLines.add(
          AdvancedLineModel(
            filePath: filePath,
            lineNumber: lineIndex,
            line: fileLine,
            lineType: LineType.normal,
          ),
        );
      } else {
        final String dependency = _extractDependency(fileLine);
        smartFileLines.add(
          AdvancedLineModel(
            filePath: filePath,
            lineNumber: lineIndex,
            line: fileLine,
            lineType: folderContents.contains(dependency) ? LineType.success : LineType.warning,
          ),
        );
      }
      lineIndex++;
    }

    return smartFileLines;
  }

  List<AdvancedLineModel> _processFolderContents({
    required String folderPath,
    required List<String> fileLines,
    required List<String> folderContents,
  }) {
    final List<AdvancedLineModel> smartFolderContents = [];
    int lineIndex = 1;

    folderContents.sort((a, b) => a.toString().toLowerCase().compareTo(b.toString().toLowerCase()));

    for (String folderItem in folderContents) {
      smartFolderContents.add(
        AdvancedLineModel(
          filePath: folderPath,
          lineNumber: lineIndex,
          line: folderItem,
          lineType: fileLines
                  .firstWhere(
                    (e) => e.contains('"${AppStrings.dependencyRelatedLine}$folderItem"'),
                    orElse: () => '',
                  )
                  .isNotEmpty
              ? LineType.success
              : LineType.warning,
        ),
      );
      lineIndex++;
    }

    return smartFolderContents;
  }

  String _extractDependency(String fileLine) {
    final int startIndex = fileLine.indexOf('/') + 1;
    final int endIndex = fileLine.lastIndexOf('"');
    return fileLine.substring(startIndex, endIndex);
  }
}
