import 'package:obfuscation_controller/app/data/editor/repository/editor_repository.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_line_model.dart';
import 'package:obfuscation_controller/app/domain/editor/service/editor_comparison_domain_layer_service.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';

class FetchFileContentsUseCase {
  final EditorRepository _editorRepository;
  final EditorComparisonDomainLayerService _editorComparisonDomainLayerService;

  const FetchFileContentsUseCase({
    required EditorRepository editorRepository,
    required EditorComparisonDomainLayerService editorComparisonDomainLayerService,
  })  : _editorRepository = editorRepository,
        _editorComparisonDomainLayerService = editorComparisonDomainLayerService;

  OperationResult<Map<String, List<AdvancedLineModel>>> execute({
    required String obfuscationFilePath,
    required String dependencyFolderPath,
  }) {
    final OperationResult<List<String>> fileLinesResult = _editorRepository.readFileContent(filePath: obfuscationFilePath);
    final OperationResult<List<String>> folderContentsResult = _editorRepository.fetchFileNamesUnderGivenFolderPath(folderPath: dependencyFolderPath);
    final OperationResult<Map<String, List<AdvancedLineModel>>> smartLinesResult = _editorComparisonDomainLayerService.compareFiles(
      filePath: obfuscationFilePath,
      fileLines: fileLinesResult.data,
      folderPath: dependencyFolderPath,
      folderContents: folderContentsResult.data,
    );

    return OperationResult<Map<String, List<AdvancedLineModel>>>(
      data: smartLinesResult.data,
      failure: fileLinesResult.failure ?? folderContentsResult.failure ?? smartLinesResult.failure,
    );
  }
}
