import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/editor/provider/editor_view.provider.dart';
import 'package:obfuscation_controller/config/app_icons.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_editor_field.dart';

class EditorViewDependencyFolderContents extends ConsumerWidget {
  const EditorViewDependencyFolderContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorViewState = ref.watch(EditorViewProvider.editorViewProvider);

    return AdvancedEditorField(
      title: editorViewState.dependencyFolderPath.isEmpty ? ref.translateText(textType: TextType.dependencyFolder) : '${ref.translateText(textType: TextType.dependencyFolder)} (${editorViewState.dependencyFolderPath})',
      titleIcon: AppIcons.openFolderIcon,
      editorLines: editorViewState.dependencyFolderContents,
      itemScrollController: editorViewState.dependencyFolderScrollController,
    );
  }
}
