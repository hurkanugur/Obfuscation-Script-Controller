import 'package:obfuscation_controller/app/data/file/repository/file_repository.dart';
import 'package:obfuscation_controller/app/domain/file/model/advanced_line_model.dart';
import 'package:obfuscation_controller/app/domain/file/service/file_comparison_domain_layer_service.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';

class FetchFileContentsUseCase {
  final FileRepository _fileRepository;
  final FileComparisonDomainLayerService _fileComparisonDomainLayerService;

  const FetchFileContentsUseCase({
    required FileRepository fileRepository,
    required FileComparisonDomainLayerService fileComparisonDomainLayerService,
  })  : _fileRepository = fileRepository,
        _fileComparisonDomainLayerService = fileComparisonDomainLayerService;

  OperationResult<Map<String, List<AdvancedLineModel>>> execute({
    required String obfuscationFilePath,
    required String dependencyFolderPath,
  }) {
    final OperationResult<List<String>> fileLinesResult = _fileRepository.readFileContent(filePath: obfuscationFilePath);
    final OperationResult<List<String>> folderContentsResult = _fileRepository.fetchFileNamesUnderGivenFolderPath(folderPath: dependencyFolderPath);
    final OperationResult<Map<String, List<AdvancedLineModel>>> smartLinesResult = _fileComparisonDomainLayerService.compareFiles(
      filePath: obfuscationFilePath,
      fileLines: fileLinesResult.data,
      folderPath: dependencyFolderPath,
      folderContents: folderContentsResult.data,
    );

    return OperationResult<Map<String, List<AdvancedLineModel>>>(
      data: smartLinesResult.data,
      failures: [
        ...?fileLinesResult.failures,
        ...?folderContentsResult.failures,
        ...?smartLinesResult.failures,
      ],
    );
  }
}
