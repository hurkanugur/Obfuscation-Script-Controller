import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/file/provider/file_domain_layer_provider.dart';
import 'package:obfuscation_controller/app/presentation/editor/controller/editor_view_controller.dart';

class EditorViewProvider {
  const EditorViewProvider._();

  static final editorViewProvider = StateNotifierProvider<EditorViewController, EditorViewState>(
    (ref) => EditorViewController(
      fetchFileContentsUseCase: ref.watch(FileDomainLayerProvider.fetchFileContentsUseCaseProvider),
    ),
  );
}
