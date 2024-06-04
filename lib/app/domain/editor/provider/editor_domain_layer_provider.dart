import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/data/editor/provider/editor_data_layer_provider.dart';
import 'package:obfuscation_controller/app/data/editor/repository/editor_repository.dart';
import 'package:obfuscation_controller/app/domain/editor/service/editor_comparison_domain_layer_service.dart';
import 'package:obfuscation_controller/app/domain/editor/usecase/fetch_file_contents_usecase.dart';
import 'package:obfuscation_controller/app/domain/editor/usecase/pick_dependency_folder_usecase.dart';
import 'package:obfuscation_controller/app/domain/editor/usecase/pick_obfuscation_file_usecase.dart';

class EditorDomainLayerProvider {
  const EditorDomainLayerProvider._();

  /// Provider for [EditorRepository].
  static final editorComparisonDomainLayerProvider = Provider<EditorComparisonDomainLayerService>((ref) {
    return EditorComparisonDomainLayerService();
  });

  /// Provider for [FetchFileContentsUseCase].
  static final fetchFileContentsUseCaseProvider = Provider<FetchFileContentsUseCase>((ref) {
    return FetchFileContentsUseCase(
      editorComparisonDomainLayerService: ref.watch(editorComparisonDomainLayerProvider),
      editorRepository: ref.watch(EditorDataLayerProvider.editorRepositoryProvider),
    );
  });

  /// Provider for [PickObfuscationFileUseCase].
  static final pickObfuscationFileUseCaseProvider = Provider<PickObfuscationFileUseCase>((ref) {
    return PickObfuscationFileUseCase(
      editorRepository: ref.watch(EditorDataLayerProvider.editorRepositoryProvider),
    );
  });

  /// Provider for [PickDependencyFolderUseCase].
  static final pickDependencyFolderUseCaseUseCaseProvider = Provider<PickDependencyFolderUseCase>((ref) {
    return PickDependencyFolderUseCase(
      editorRepository: ref.watch(EditorDataLayerProvider.editorRepositoryProvider),
    );
  });
}
