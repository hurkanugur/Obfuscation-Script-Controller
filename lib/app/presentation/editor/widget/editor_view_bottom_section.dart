import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_console_line_model.dart';
import 'package:obfuscation_controller/app/presentation/editor/provider/editor_view.provider.dart';
import 'package:obfuscation_controller/core/widgets/advanced_debug_console.dart';

class EditorViewBottomSection extends ConsumerWidget {
  const EditorViewBottomSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorViewState = ref.watch(EditorViewProvider.editorViewProvider);

    return AdvancedDebugConsole(
      scrollController: editorViewState.debugConsoleScrollController,
      consoleLines: editorViewState.consoleLines,
      onItemTap: (ref, advancedConsoleLineModel) async => await _onItemTap(ref: ref, advancedConsoleLineModel: advancedConsoleLineModel),
    );
  }

  Future<void> _onItemTap({required WidgetRef ref, required AdvancedConsoleLineModel advancedConsoleLineModel}) async {
    final editorViewController = ref.read(EditorViewProvider.editorViewProvider.notifier);

    if (advancedConsoleLineModel.obfuscationFileLine != null && advancedConsoleLineModel.obfuscationLineNumber != null) {
      editorViewController.obfuscationFileScrollToIndex(targetIndex: advancedConsoleLineModel.obfuscationLineNumber! - 1);
    }
    if (advancedConsoleLineModel.dependencyFolderLine != null && advancedConsoleLineModel.dependencyLineNumber != null) {
      editorViewController.dependencyFolderScrollToIndex(targetIndex: advancedConsoleLineModel.dependencyLineNumber! - 1);
    }
  }
}
