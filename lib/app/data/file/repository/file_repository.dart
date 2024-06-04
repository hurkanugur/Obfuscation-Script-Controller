import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:obfuscation_controller/app/data/file/source/file_local_data_source.dart';

class FileRepository {
  final FileLocalDataSource _fileLocalDataSource;

  const FileRepository({required FileLocalDataSource fileLocalDataSource}) : _fileLocalDataSource = fileLocalDataSource;

  OperationResult<List<String>> fetchFileNamesUnderGivenFolderPath({required String folderPath}) {
    return _fileLocalDataSource.fetchFileNamesUnderGivenFolderPath(folderPath: folderPath);
  }

  OperationResult<List<String>> readFileContent({required String filePath}) {
    return _fileLocalDataSource.readFileContent(filePath: filePath);
  }
}
