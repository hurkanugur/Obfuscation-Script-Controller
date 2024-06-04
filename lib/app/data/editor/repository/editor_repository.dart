import 'package:file_picker/file_picker.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:obfuscation_controller/app/data/editor/source/editor_local_data_source.dart';
import 'package:obfuscation_controller/core/file/service/file_service.dart';

class EditorRepository {
  final EditorLocalDataSource _editorLocalDataSource;
  final FileService _fileService;

  const EditorRepository({
    required EditorLocalDataSource editorLocalDataSource,
    required FileService fileService,
  })  : _editorLocalDataSource = editorLocalDataSource,
        _fileService = fileService;

  OperationResult<List<String>> fetchFileNamesUnderGivenFolderPath({required String folderPath}) {
    return _editorLocalDataSource.fetchFileNamesUnderGivenFolderPath(folderPath: folderPath);
  }

  OperationResult<List<String>> readFileContent({required String filePath}) {
    return _editorLocalDataSource.readFileContent(filePath: filePath);
  }

  Future<OperationResult<String?>> pickObfuscationFile() async {
    return _fileService.pickFilePath(fileType: FileType.custom, allowedExtensions: ['txt']);
  }

  Future<OperationResult<String?>> pickDependencyFolder() async {
    return _fileService.pickFolderPath();
  }
}
