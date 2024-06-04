import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/file/service/file_service.dart';

class FileProvider {
  const FileProvider._();

  /// Provider for [FileService].
  static final fileServiceProvider = Provider<FileService>((ref) {
    return const FileService();
  });
}
