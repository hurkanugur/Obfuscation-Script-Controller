import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/data/editor/repository/editor_repository.dart';
import 'package:obfuscation_controller/app/data/editor/source/editor_local_data_source.dart';
import 'package:obfuscation_controller/core/file/provider/file_provider.dart';

class EditorDataLayerProvider {
  const EditorDataLayerProvider._();

  /// Provider for [EditorRepository].
  static final editorRepositoryProvider = Provider<EditorRepository>((ref) {
    return EditorRepository(
      editorLocalDataSource: ref.watch(editorDataSourceProvider),
      fileService: ref.watch(FileProvider.fileServiceProvider),
    );
  });

  /// Provider for [EditorRepository].
  static final editorDataSourceProvider = Provider<EditorLocalDataSource>((ref) {
    return EditorLocalDataSource();
  });
}
