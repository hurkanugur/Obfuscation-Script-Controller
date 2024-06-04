import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/data/file/repository/file_repository.dart';
import 'package:obfuscation_controller/app/data/file/source/file_local_data_source.dart';

class FileDataLayerProvider {
  const FileDataLayerProvider._();

  /// Provider for [FileRepository].
  static final fileRepositoryProvider = Provider<FileRepository>((ref) {
    return FileRepository(
      fileLocalDataSource: ref.watch(fileDataSourceProvider),
    );
  });

  /// Provider for [FileRepository].
  static final fileDataSourceProvider = Provider<FileLocalDataSource>((ref) {
    return FileLocalDataSource();
  });
}
