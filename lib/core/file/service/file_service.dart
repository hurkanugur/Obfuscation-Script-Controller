import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obfuscation_controller/config/app_regex.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  const FileService();

  /// Returns the size of Application Documents Directory.
  ///
  /// Returns `null` when the operation fails.
  Future<OperationResult<int?>> getApplicationDocumentsDirectorySize() async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      int size = 0;

      final List<FileSystemEntity> systemEntities = appDocDir.listSync(recursive: true, followLinks: false);
      for (FileSystemEntity entity in systemEntities) {
        if (entity is File) {
          size += await entity.length();
        }
      }

      return OperationResult(data: size, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.deviceDirectoryFetchSizeOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// Returns the size of Temporary Directory.
  ///
  /// Returns `null` when the operation fails.
  Future<OperationResult<int?>> getTemporaryDirectorySize() async {
    try {
      await createTemporaryDirectoryIfNotExists();

      final Directory tempDir = await getTemporaryDirectory();
      int size = 0;

      final List<FileSystemEntity> systemEntities = tempDir.listSync(recursive: true, followLinks: false);
      for (FileSystemEntity entity in systemEntities) {
        if (entity is File) {
          size += await entity.length();
        }
      }

      return OperationResult(data: size, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.deviceDirectoryFetchSizeOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// Creates the Application Documents Directory if it does not exist.
  Future<OperationResult<void>> createApplicationDocumentsDirectoryIfNotExists() async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();

      if (!appDocDir.existsSync()) {
        appDocDir.createSync(recursive: true);
      }

      return const OperationResult(data: null, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.deviceDirectoryCreateOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// Creates the Temporary Directory if it does not exist.
  Future<OperationResult<void>> createTemporaryDirectoryIfNotExists() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();

      if (!tempDir.existsSync()) {
        tempDir.createSync(recursive: true);
      }

      return const OperationResult(data: null, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.deviceDirectoryCreateOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// Deletes the Temporary Directory which is used for storing caches.
  ///
  /// Returns `true` when the folder is deleted successfully.
  Future<OperationResult<bool>> deleteTemporaryDirectory() async {
    try {
      final Directory temporaryDirectory = await getTemporaryDirectory();

      if (temporaryDirectory.existsSync()) {
        temporaryDirectory.deleteSync(recursive: true);
      }

      return const OperationResult(data: true, failure: null);
    } catch (ex) {
      return OperationResult(
        data: false,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.deviceDirectoryDeleteOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// Deletes the Application Documents Folder used for pesistent data storage.
  ///
  /// Returns `true` when the folder is deleted successfully.
  Future<OperationResult<bool>> deleteApplicationDocumentsFolder() async {
    try {
      final Directory applicationDocumentsDirectory = await getApplicationDocumentsDirectory();

      if (applicationDocumentsDirectory.existsSync()) {
        applicationDocumentsDirectory.deleteSync(recursive: true);
      }

      return const OperationResult(data: true, failure: null);
    } catch (ex) {
      return OperationResult(
        data: false,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.deviceDirectoryDeleteOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// Reads the data from assets folder.
  ///
  /// Returns `null` when the operation fails.
  Future<OperationResult<ByteData?>> readDataFromAssetsFolder({required String dataPath}) async {
    try {
      final ByteData byteData = await rootBundle.load(dataPath);
      return OperationResult(data: byteData, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileReadOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to preview a file without downloading it.
  ///
  /// Returns [ResultType] which represents the operation result.
  ///
  /// The data is stored in the platform's temporary cache folder, where the data is not persistent.
  ///
  /// [fileName] can be given as 'test.txt' or 'test.png' etc.
  Future<OperationResult<ResultType>> previewMediaFile({
    required String fileName,
    required String base64Data,
  }) async {
    try {
      fileName = fileName.replaceAll(AppRegex.forbiddenFileNameCharacterRegex, '_');
      fileName = _addDateTimeInToFileName(fileName: fileName);

      final Uint8List data = const Base64Decoder().convert(base64Data);

      await createTemporaryDirectoryIfNotExists();

      final String directoryPath = (await getTemporaryDirectory()).path;
      final String fileLocation = '$directoryPath/$fileName';
      final File file = File(fileLocation);

      await file.writeAsBytes(data);

      final OpenResult openFileResult = await OpenFilex.open(fileLocation);

      if (openFileResult.type == ResultType.noAppToOpen) {
        return OperationResult(
          data: openFileResult.type,
          failure: ClientFailure.createAndLog(
            stackTrace: StackTrace.current,
            clientExceptionType: ClientExceptionType.noApplicationFoundToOpenTheFileError,
            exception: openFileResult.message,
          ),
        );
      }

      return OperationResult(data: openFileResult.type, failure: null);
    } catch (ex) {
      return OperationResult(
        data: ResultType.error,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileOpenOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to read file from the gallery.
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: Gallery Access Permission is required before calling this method.
  Future<OperationResult<Uint8List?>> pickFileFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      final bool didUserSelectFile = (file == null) ? false : true;

      if (didUserSelectFile) {
        final Uint8List uint8list = await file.readAsBytes();
        return OperationResult(data: uint8list, failure: null);
      }

      return const OperationResult(data: null, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileReadOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to take a photo, then read the image by using camera.
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: Camera Access Permission is required before calling this method.
  Future<OperationResult<Uint8List?>> pickImageFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.camera);
      final bool didUserTakePhoto = (file == null) ? false : true;

      if (didUserTakePhoto) {
        final Uint8List uint8list = await file.readAsBytes();
        return OperationResult(data: uint8list, failure: null);
      }

      return const OperationResult(data: null, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileReadOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to read file from the documents and downloads folder.
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: Storage Access Permission is required before calling this method.
  Future<OperationResult<Uint8List?>> pickFileFromDocumentsAndDownloadsFolder() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      final bool didUserSelectFile = (result == null) ? false : true;

      if (didUserSelectFile) {
        final PlatformFile file = result.files.first;
        return OperationResult(data: file.bytes, failure: null);
      }

      return const OperationResult(data: null, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileReadOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to read file path from selection.
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: Storage Access Permission is required before calling this method.
  Future<OperationResult<String?>> pickFilePath({
    required List<String>? allowedExtensions,
    required FileType fileType,
  }) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: allowedExtensions,
      );
      final bool didUserSelectFile = (result == null) ? false : true;

      if (didUserSelectFile) {
        final PlatformFile file = result.files.first;
        return OperationResult(data: file.path, failure: null);
      }

      return const OperationResult(data: null, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileReadOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to read folder path from selection.
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: Storage Access Permission is required before calling this method.
  Future<OperationResult<String?>> pickFolderPath() async {
    try {
      final String? result = await FilePicker.platform.getDirectoryPath();
      final bool didUserSelectFile = (result == null) ? false : true;

      if (didUserSelectFile) {
        return OperationResult(data: result, failure: null);
      }

      return const OperationResult(data: null, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileReadOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to write text files into a folder that the user cannot access.
  ///
  /// Returns the saved file path when the operation succeeds.
  ///
  /// The file is stored in a place under the Mobile Application's folder (It is hard for the user to find it).
  ///
  /// `Example`: [fileName] can be given as 'test.txt'. (IT MUST BE A TEXT FILE).
  Future<OperationResult<bool>> saveFileIntoApplicationDocumentsDirectory({
    required String fileName,
    required String content,
  }) async {
    try {
      await createApplicationDocumentsDirectoryIfNotExists();

      final String directoryPath = (await getApplicationDocumentsDirectory()).path;
      final String filePath = '$directoryPath/$fileName';
      final File file = File(filePath);

      file.writeAsStringSync(content);

      return const OperationResult(data: true, failure: null);
    } catch (ex) {
      return OperationResult(
        data: false,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileReadOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to read text files from a folder that the user cannot access.
  ///
  /// Returns the saved file path when the operation succeeds.
  ///
  /// The file is stored in a place under the Mobile Application's folder (It is hard for the user to find it).
  ///
  /// `Example`: [fileName] can be given as 'test.txt'. (IT MUST BE A TEXT FILE).
  Future<OperationResult<String?>> readFileFromApplicationDocumentsDirectory({required String fileName}) async {
    try {
      await createApplicationDocumentsDirectoryIfNotExists();

      final String directoryPath = (await getApplicationDocumentsDirectory()).path;
      final String externalFilePath = '$directoryPath/$fileName';
      final File file = File(externalFilePath);

      if (!file.existsSync()) {
        return OperationResult(
          data: null,
          failure: ClientFailure.createAndLog(
            stackTrace: StackTrace.current,
            clientExceptionType: ClientExceptionType.fileNotFoundError,
          ),
        );
      }

      final String content = await file.readAsString();

      return OperationResult(data: content, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileWriteOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to delete files from a folder that the user cannot access.
  ///
  /// The file is stored in a place under the Mobile Application's folder (It is hard for the user to find it).
  ///
  /// `Example`: [fileName] can be given as 'test.txt' or 'test.png' etc.
  Future<OperationResult<void>> deleteFileFromApplicationDocumentsDirectory({required String fileName}) async {
    try {
      await createApplicationDocumentsDirectoryIfNotExists();

      final String directoryPath = (await getApplicationDocumentsDirectory()).path;
      final String externalFilePath = '$directoryPath/$fileName';
      final File file = File(externalFilePath);

      if (!file.existsSync()) {
        return OperationResult(
          data: null,
          failure: ClientFailure.createAndLog(
            stackTrace: StackTrace.current,
            clientExceptionType: ClientExceptionType.fileNotFoundError,
          ),
        );
      }

      await file.delete();

      return const OperationResult(data: null, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.fileDeleteOperationError,
          exception: ex,
        ),
      );
    }
  }

  /// This method is used to insert the [DateTime] to the filename so that the filename can be unique.
  ///
  /// [fileName] can be given as 'test.txt' or 'test.png' etc.
  String _addDateTimeInToFileName({required String fileName}) {
    final DateTime dateTime = DateTime.now();
    final int extensionIndex = fileName.lastIndexOf('.');
    final bool hasExtension = extensionIndex != -1 ? true : false;

    final String fileNameWithDateTime;

    if (hasExtension) {
      fileNameWithDateTime = '${fileName.substring(0, extensionIndex)}_${dateTime.millisecondsSinceEpoch}${fileName.substring(extensionIndex)}';
    } else {
      fileNameWithDateTime = '${fileName}_${dateTime.millisecondsSinceEpoch}';
    }

    return fileNameWithDateTime;
  }
}
