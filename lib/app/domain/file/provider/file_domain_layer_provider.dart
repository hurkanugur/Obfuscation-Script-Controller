import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/data/file/provider/file_data_layer_provider.dart';
import 'package:obfuscation_controller/app/data/file/repository/file_repository.dart';
import 'package:obfuscation_controller/app/domain/file/service/file_comparison_domain_layer_service.dart';
import 'package:obfuscation_controller/app/domain/file/usecase/fetch_file_contents_usecase.dart';

class FileDomainLayerProvider {
  const FileDomainLayerProvider._();

  /// Provider for [FileRepository].
  static final fileComparisonDomainLayerProvider = Provider<FileComparisonDomainLayerService>((ref) {
    return FileComparisonDomainLayerService();
  });

  /// Provider for [FetchFileContentsUseCase].
  static final fetchFileContentsUseCaseProvider = Provider<FetchFileContentsUseCase>((ref) {
    return FetchFileContentsUseCase(
      fileComparisonDomainLayerService: ref.watch(fileComparisonDomainLayerProvider),
      fileRepository: ref.watch(FileDataLayerProvider.fileRepositoryProvider),
    );
  });
}
