import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/editor/provider/editor_view.provider.dart';
import 'package:obfuscation_controller/core/widgets/advanced_editor_field.dart';

class EditorViewObfuscationFileContents extends ConsumerWidget {
  const EditorViewObfuscationFileContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorViewState = ref.watch(EditorViewProvider.editorViewProvider);

    return AdvancedEditorField(
      smartLines: editorViewState.obfuscationFileLines,
      itemScrollController: editorViewState.obfuscationFileScrollController,
    );
  }
}
