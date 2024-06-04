import 'dart:io';

import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';

class FileLocalDataSource {
  OperationResult<List<String>> fetchFileNamesUnderGivenFolderPath({required String folderPath}) {
    final Directory directory = Directory(folderPath);

    if (directory.existsSync()) {
      final List<FileSystemEntity> entities = directory.listSync();
      final List<String> fileNames = entities.map((file) => file.uri.pathSegments.last).toList();
      return OperationResult(data: fileNames, failures: null);
    } else {
      return OperationResult(
        data: [],
        failures: [
          ClientFailure.createAndLog(
            stackTrace: StackTrace.current,
            clientExceptionType: ClientExceptionType.fileNotFoundError,
          ),
        ],
      );
    }
  }

  OperationResult<List<String>> readFileContent({required String filePath}) {
    try {
      final File file = File(filePath);

      if (file.existsSync()) {
        final List<String> lines = file.readAsLinesSync();
        return OperationResult(data: lines, failures: null);
      } else {
        return OperationResult(
          data: [],
          failures: [
            ClientFailure.createAndLog(
              stackTrace: StackTrace.current,
              clientExceptionType: ClientExceptionType.fileNotFoundError,
            ),
          ],
        );
      }
    } catch (ex) {
      return OperationResult(
        data: [],
        failures: [
          ClientFailure.createAndLog(
            stackTrace: StackTrace.current,
            clientExceptionType: ClientExceptionType.fileReadOperationError,
            exception: ex,
          ),
        ],
      );
    }
  }
}
