import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_console_line_model.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_editor_line_model.dart';
import 'package:obfuscation_controller/app/domain/editor/usecase/fetch_file_contents_usecase.dart';
import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:obfuscation_controller/core/log/extension/snackbar_extension.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EditorViewState {
  final String obfuscationFilePath;
  final String dependencyFolderPath;
  final List<AdvancedEditorLineModel> obfuscationFileLines;
  final List<AdvancedEditorLineModel> dependencyFolderContents;
  final List<AdvancedConsoleLineModel> consoleLines;
  final ItemScrollController obfuscationFileScrollController;
  final ItemScrollController dependencyFolderScrollController;
  final ScrollController debugConsoleScrollController;
  final TextEditingController searchBarController;

  const EditorViewState({
    required this.obfuscationFilePath,
    required this.dependencyFolderPath,
    required this.obfuscationFileLines,
    required this.dependencyFolderContents,
    required this.consoleLines,
    required this.obfuscationFileScrollController,
    required this.dependencyFolderScrollController,
    required this.debugConsoleScrollController,
    required this.searchBarController,
  });

  EditorViewState copyWith({
    String? obfuscationFilePath,
    String? dependencyFolderPath,
    List<AdvancedEditorLineModel>? obfuscationFileLines,
    List<AdvancedEditorLineModel>? dependencyFolderContents,
    List<AdvancedConsoleLineModel>? consoleLines,
    ItemScrollController? obfuscationFileScrollController,
    ItemScrollController? dependencyFolderScrollController,
    ScrollController? debugConsoleScrollController,
    TextEditingController? searchBarController,
  }) {
    return EditorViewState(
      obfuscationFilePath: obfuscationFilePath ?? this.obfuscationFilePath,
      dependencyFolderPath: dependencyFolderPath ?? this.dependencyFolderPath,
      obfuscationFileLines: obfuscationFileLines ?? this.obfuscationFileLines,
      dependencyFolderContents: dependencyFolderContents ?? this.dependencyFolderContents,
      consoleLines: consoleLines ?? this.consoleLines,
      obfuscationFileScrollController: obfuscationFileScrollController ?? this.obfuscationFileScrollController,
      dependencyFolderScrollController: dependencyFolderScrollController ?? this.dependencyFolderScrollController,
      debugConsoleScrollController: debugConsoleScrollController ?? this.debugConsoleScrollController,
      searchBarController: searchBarController ?? this.searchBarController,
    );
  }
}

class EditorViewController extends StateNotifier<EditorViewState> {
  /// This method is used for debounce timer for the search field.
  static Timer? _searchDebounceTimer;

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
            consoleLines: [],
            obfuscationFileScrollController: ItemScrollController(),
            dependencyFolderScrollController: ItemScrollController(),
            debugConsoleScrollController: ScrollController(),
            searchBarController: TextEditingController(),
          ),
        );

  Future<void> fetchData({
    required String obfuscationFilePath,
    required String dependencyFolderPath,
    required WidgetRef ref,
  }) async {
    final OperationResult<(List<AdvancedEditorLineModel>, List<AdvancedEditorLineModel>, List<AdvancedConsoleLineModel>)> operationResult = _fetchFileContentsUseCase.execute(
      obfuscationFilePath: obfuscationFilePath,
      dependencyFolderPath: dependencyFolderPath,
    );

    if (operationResult.hasData) {
      state = state.copyWith(
        obfuscationFilePath: obfuscationFilePath,
        obfuscationFileLines: operationResult.data.$1,
        dependencyFolderPath: dependencyFolderPath,
        dependencyFolderContents: operationResult.data.$2,
        consoleLines: operationResult.data.$3,
      );
    }

    if (operationResult.hasFailure) {
      ref.showFailureSnackbar(failure: operationResult.failure!);
    }
  }

  Future<void> obfuscationFileScrollToIndex({required int targetIndex}) async {
    if (state.obfuscationFileScrollController.isAttached) {
      state.obfuscationFileLines[targetIndex] = state.obfuscationFileLines.elementAt(targetIndex).copyWith(isBeingFocused: true);
      state = state.copyWith();

      await state.obfuscationFileScrollController.scrollTo(
        index: targetIndex,
        alignment: 0.5,
        opacityAnimationWeights: [20, 20, 60],
        duration: const Duration(milliseconds: AnimationConstants.listScrollAnimationDurationMS),
        curve: AnimationConstants.listScrollAnimationCurve,
      );

      await Future.delayed(const Duration(milliseconds: AnimationConstants.editorLineHighlightDuration));
      state.obfuscationFileLines[targetIndex] = state.obfuscationFileLines.elementAt(targetIndex).copyWith(isBeingFocused: false);
      state = state.copyWith();
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
      state.dependencyFolderContents[targetIndex] = state.dependencyFolderContents.elementAt(targetIndex).copyWith(isBeingFocused: true);
      state = state.copyWith();

      await state.dependencyFolderScrollController.scrollTo(
        index: targetIndex,
        alignment: 0.5,
        opacityAnimationWeights: [20, 20, 60],
        duration: const Duration(milliseconds: AnimationConstants.listScrollAnimationDurationMS),
        curve: AnimationConstants.listScrollAnimationCurve,
      );

      await Future.delayed(const Duration(milliseconds: AnimationConstants.editorLineHighlightDuration));
      state.dependencyFolderContents[targetIndex] = state.dependencyFolderContents.elementAt(targetIndex).copyWith(isBeingFocused: false);
      state = state.copyWith();
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

  Future<void> scrollBySearchBarValue({required String searchbarText}) async {
    if (_searchDebounceTimer?.isActive ?? false) {
      _searchDebounceTimer?.cancel();
    }

    _searchDebounceTimer = Timer(const Duration(milliseconds: AnimationConstants.searchDebounceTimeMilliseconds), () async {
      final String lowercaseSearchValue = searchbarText.toLowerCase();
      final int obfuscationFileIndex = state.obfuscationFileLines.indexWhere((element) => element.line.toLowerCase().contains(lowercaseSearchValue));
      final int dependencyFolderIndex = state.dependencyFolderContents.indexWhere((element) => element.line.toLowerCase().contains(lowercaseSearchValue));

      if (obfuscationFileIndex >= 0) {
        obfuscationFileScrollToIndex(targetIndex: obfuscationFileIndex);
      }

      if (dependencyFolderIndex >= 0) {
        dependencyFolderScrollToIndex(targetIndex: dependencyFolderIndex);
      }
    });
  }

  void resetState() {
    state = EditorViewState(
      obfuscationFilePath: '',
      dependencyFolderPath: '',
      obfuscationFileLines: [],
      dependencyFolderContents: [],
      consoleLines: [],
      obfuscationFileScrollController: ItemScrollController(),
      dependencyFolderScrollController: ItemScrollController(),
      debugConsoleScrollController: ScrollController(),
      searchBarController: TextEditingController(),
    );
  }
}
