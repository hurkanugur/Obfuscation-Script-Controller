import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/data/auth/source/local/db_user_table.dart';
import 'package:obfuscation_controller/core/storage/provider/storage_provider.dart';

class AuthProvider {
  const AuthProvider._();

  // Local Data Source Providers

  /// Provider for [DBUserTable].
  static final dbUserTableProvider = Provider<DBUserTable>((ref) {
    return DBUserTable(
      databaseService: ref.watch(StorageProvider.databaseServiceProvider),
    );
  });
}
