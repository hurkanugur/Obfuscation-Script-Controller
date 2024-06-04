import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/editor/enum/line_type.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_line_model.dart';
import 'package:obfuscation_controller/app/domain/editor/usecase/fetch_file_contents_usecase.dart';
import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:obfuscation_controller/core/log/extension/snackbar_extension.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EditorViewState {
  final String obfuscationFilePath;
  final String dependencyFolderPath;
  final List<AdvancedLineModel> obfuscationFileLines;
  final List<AdvancedLineModel> dependencyFolderContents;
  final ItemScrollController obfuscationFileScrollController;
  final ItemScrollController dependencyFolderScrollController;
  final ScrollController debugConsoleScrollController;

  const EditorViewState({
    required this.obfuscationFilePath,
    required this.dependencyFolderPath,
    required this.obfuscationFileLines,
    required this.dependencyFolderContents,
    required this.obfuscationFileScrollController,
    required this.dependencyFolderScrollController,
    required this.debugConsoleScrollController,
  });

  EditorViewState copyWith({
    String? obfuscationFilePath,
    String? dependencyFolderPath,
    List<AdvancedLineModel>? obfuscationFileLines,
    List<AdvancedLineModel>? dependencyFolderContents,
    ItemScrollController? obfuscationFileScrollController,
    ItemScrollController? dependencyFolderScrollController,
    ScrollController? debugConsoleScrollController,
  }) {
    return EditorViewState(
      obfuscationFilePath: obfuscationFilePath ?? this.obfuscationFilePath,
      dependencyFolderPath: dependencyFolderPath ?? this.dependencyFolderPath,
      obfuscationFileLines: obfuscationFileLines ?? this.obfuscationFileLines,
      dependencyFolderContents: dependencyFolderContents ?? this.dependencyFolderContents,
      obfuscationFileScrollController: obfuscationFileScrollController ?? this.obfuscationFileScrollController,
      dependencyFolderScrollController: dependencyFolderScrollController ?? this.dependencyFolderScrollController,
      debugConsoleScrollController: debugConsoleScrollController ?? this.debugConsoleScrollController,
    );
  }
}

class EditorViewController extends StateNotifier<EditorViewState> {
  final FetchFileContentsUseCase _fetchFileContentsUseCase;

  EditorViewController({
    required FetchFileContentsUseCase fetchFileContentsUseCase,
  })  : _fetchFileContentsUseCase = fetchFileContentsUseCase,
        super(
          EditorViewState(
            obfuscationFilePath: '',
            dependencyFolderPath: '',
            obfuscationFileLines: [],
            dependencyFolderContents: [],
            obfuscationFileScrollController: ItemScrollController(),
            dependencyFolderScrollController: ItemScrollController(),
            debugConsoleScrollController: ScrollController(),
          ),
        );

  Future<void> fetchData({
    required String obfuscationFilePath,
    required String dependencyFolderPath,
    required WidgetRef ref,
  }) async {
    final OperationResult<Map<String, List<AdvancedLineModel>>> smartLinesResult = _fetchFileContentsUseCase.execute(
      obfuscationFilePath: obfuscationFilePath,
      dependencyFolderPath: dependencyFolderPath,
    );

    if (smartLinesResult.hasData) {
      state = state.copyWith(
        obfuscationFilePath: smartLinesResult.data.values.first.isEmpty ? '' : smartLinesResult.data.values.first.first.filePath,
        obfuscationFileLines: smartLinesResult.data.values.first,
        dependencyFolderPath: smartLinesResult.data.values.last.isEmpty ? '' : smartLinesResult.data.values.last.first.filePath,
        dependencyFolderContents: smartLinesResult.data.values.last,
      );
    }

    if (smartLinesResult.hasFailure) {
      ref.showFailureSnackbar(failure: smartLinesResult.failure!);
    }
  }

  Future<void> obfuscationFileScrollToIndex({required int targetIndex}) async {
    if (state.obfuscationFileScrollController.isAttached) {
      await state.obfuscationFileScrollController.scrollTo(
        index: targetIndex,
        alignment: 0.5,
        opacityAnimationWeights: [20, 20, 60],
        duration: const Duration(seconds: 1),
        curve: AnimationConstants.listScrollAnimationCurve,
      );
    }
  }

  void obfuscationFileJumpToBeginning() async {
    if (state.obfuscationFileScrollController.isAttached) {
      state.obfuscationFileScrollController.jumpTo(
        index: 0,
        alignment: 0,
      );
    }
  }

  Future<void> obfuscationFileScrollToEnd() async {
    final int endIndex = state.obfuscationFileLines.length - 1;

    if (endIndex < 0) {
      return;
    }

    await obfuscationFileScrollToIndex(targetIndex: endIndex);
  }

  Future<void> dependencyFolderScrollToIndex({required int targetIndex}) async {
    if (state.dependencyFolderScrollController.isAttached) {
      await state.dependencyFolderScrollController.scrollTo(
        index: targetIndex,
        alignment: 0.5,
        opacityAnimationWeights: [20, 20, 60],
        duration: const Duration(seconds: 1),
        curve: AnimationConstants.listScrollAnimationCurve,
      );
    }
  }

  void dependencyFolderJumpToBeginning() async {
    if (state.dependencyFolderScrollController.isAttached) {
      state.dependencyFolderScrollController.jumpTo(
        index: 0,
        alignment: 0,
      );
    }
  }

  Future<void> dependencyFolderScrollToEnd() async {
    final int endIndex = state.dependencyFolderContents.length - 1;

    if (endIndex < 0) {
      return;
    }

    await dependencyFolderScrollToIndex(targetIndex: endIndex);
  }

  int getNumberOfErrors() {
    final int fileContentErrorsCount = state.obfuscationFileLines.where((e) => e.lineType == LineType.warning).length;
    final int folderContentErrorsCount = state.dependencyFolderContents.where((e) => e.lineType == LineType.warning).length;
    return fileContentErrorsCount + folderContentErrorsCount;
  }

  bool isObfuscationFileLine({required String filePath}) {
    return filePath == state.obfuscationFilePath;
  }

  bool isDependencyFolderLine({required String filePath}) {
    return filePath == state.dependencyFolderPath;
  }

  List<AdvancedLineModel> getSortedErrorList() {
    final List<AdvancedLineModel> fileContentErrorLines = state.obfuscationFileLines.where((e) => e.lineType == LineType.warning).toList();
    final List<AdvancedLineModel> folderContentErrorLines = state.dependencyFolderContents.where((e) => e.lineType == LineType.warning).toList();
    final List<AdvancedLineModel> combinedList = [...fileContentErrorLines, ...folderContentErrorLines];
    combinedList.sort((a, b) => a.lineNumber.compareTo(b.lineNumber));
    return combinedList;
  }

  void resetState() {
    state = EditorViewState(
      obfuscationFilePath: '',
      dependencyFolderPath: '',
      obfuscationFileLines: [],
      dependencyFolderContents: [],
      obfuscationFileScrollController: ItemScrollController(),
      dependencyFolderScrollController: ItemScrollController(),
      debugConsoleScrollController: ScrollController(),
    );
  }
}
