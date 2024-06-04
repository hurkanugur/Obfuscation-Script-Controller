import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/storage/service/database_service.dart';
import 'package:obfuscation_controller/core/storage/service/shares_preference_service.dart';

class StorageProvider {
  const StorageProvider._();

  /// Provider for [SharedPreferenceService].
  static final sharedPreferenceServiceProvider = Provider<SharedPreferenceService>((ref) {
    throw UnimplementedError();
  });

  /// Provider for [DatabaseService].
  static final databaseServiceProvider = Provider<DatabaseService>((ref) {
    return DatabaseService(database: null);
  });
}
