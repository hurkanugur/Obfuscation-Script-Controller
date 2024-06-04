import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_line_model.dart';
import 'package:obfuscation_controller/app/presentation/editor/provider/editor_view.provider.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_debug_console.dart';

class EditorViewBottomSection extends ConsumerWidget {
  const EditorViewBottomSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorViewController = ref.read(EditorViewProvider.editorViewProvider.notifier);
    final editorViewState = ref.watch(EditorViewProvider.editorViewProvider);
    final List<AdvancedLineModel> sortedErrorList = editorViewController.getSortedErrorList();

    return AdvancedDebugConsole(
      scrollController: editorViewState.debugConsoleScrollController,
      sortedErrorList: sortedErrorList,
      errorMessageCreator: (ref, advancedLineModel) => _createErrorMessage(ref: ref, advancedLineModel: advancedLineModel),
      onItemTap: (ref, advancedLineModel) async => await _onItemTap(ref: ref, advancedLineModel: advancedLineModel),
    );
  }

  Future<void> _onItemTap({required WidgetRef ref, required AdvancedLineModel advancedLineModel}) async {
    final editorViewController = ref.read(EditorViewProvider.editorViewProvider.notifier);

    if (editorViewController.isObfuscationFileLine(filePath: advancedLineModel.filePath)) {
      editorViewController.obfuscationFileScrollToIndex(targetIndex: advancedLineModel.lineNumber - 1);
    } else {
      editorViewController.dependencyFolderScrollToIndex(targetIndex: advancedLineModel.lineNumber - 1);
    }
  }

  String _createErrorMessage({required WidgetRef ref, required AdvancedLineModel advancedLineModel}) {
    final editorViewController = ref.read(EditorViewProvider.editorViewProvider.notifier);

    final String translatedText;

    if (editorViewController.isObfuscationFileLine(filePath: advancedLineModel.filePath)) {
      translatedText = ref.translateText(textType: TextType.noSuchDependencyFound);
      return translatedText.replaceAll('[DEPENDENCY]', _extractDependency(advancedLineModel.line));
    } else {
      translatedText = ref.translateText(textType: TextType.dependencyNeverMentionedInObfuscationFile);
      return translatedText.replaceAll('[DEPENDENCY]', advancedLineModel.line);
    }
  }

  String _extractDependency(String fileLine) {
    final int startIndex = fileLine.indexOf('/') + 1;
    final int endIndex = fileLine.lastIndexOf('"');
    return fileLine.substring(startIndex, endIndex);
  }
}
