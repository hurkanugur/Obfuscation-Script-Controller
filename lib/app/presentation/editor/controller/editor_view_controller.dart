import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/file/model/advanced_line_model.dart';
import 'package:obfuscation_controller/app/domain/file/usecase/fetch_file_contents_usecase.dart';
import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EditorViewState {
  final List<AdvancedLineModel> obfuscationFileLines;
  final List<AdvancedLineModel> dependencyFolderContents;
  final ItemScrollController obfuscationFileScrollController;
  final ItemScrollController dependencyFolderScrollController;

  const EditorViewState({
    required this.obfuscationFileLines,
    required this.dependencyFolderContents,
    required this.obfuscationFileScrollController,
    required this.dependencyFolderScrollController,
  });

  EditorViewState copyWith({
    List<AdvancedLineModel>? obfuscationFileLines,
    List<AdvancedLineModel>? dependencyFolderContents,
    ItemScrollController? obfuscationFileScrollController,
    ItemScrollController? dependencyFolderScrollController,
  }) {
    return EditorViewState(
      obfuscationFileLines: obfuscationFileLines ?? this.obfuscationFileLines,
      dependencyFolderContents: dependencyFolderContents ?? this.dependencyFolderContents,
      obfuscationFileScrollController: obfuscationFileScrollController ?? this.obfuscationFileScrollController,
      dependencyFolderScrollController: dependencyFolderScrollController ?? this.dependencyFolderScrollController,
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
            obfuscationFileLines: [],
            dependencyFolderContents: [],
            obfuscationFileScrollController: ItemScrollController(),
            dependencyFolderScrollController: ItemScrollController(),
          ),
        );

  Future<void> fetchData({
    required String obfuscationFilePath,
    required String dependencyFolderPath,
  }) async {
    final OperationResult<Map<String, List<AdvancedLineModel>>> smartLinesResult = _fetchFileContentsUseCase.execute(
      obfuscationFilePath: obfuscationFilePath,
      dependencyFolderPath: dependencyFolderPath,
    );

    if (smartLinesResult.hasData) {
      state = state.copyWith(
        obfuscationFileLines: smartLinesResult.data.values.first,
        dependencyFolderContents: smartLinesResult.data.values.last,
      );
    }

    if (smartLinesResult.hasFailures) {
      // TODO Show snackbars for error
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

  void resetState() {
    state = EditorViewState(
      obfuscationFileLines: [],
      dependencyFolderContents: [],
      obfuscationFileScrollController: ItemScrollController(),
      dependencyFolderScrollController: ItemScrollController(),
    );
  }
}
