import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/storage/provider/storage_provider.dart';
import 'package:obfuscation_controller/core/storage/service/shares_preference_service.dart';

extension SharedPreferenceExtension on WidgetRef {
  /// A getter for [SharedPreferenceService].
  SharedPreferenceService get sharedPreference => read(StorageProvider.sharedPreferenceServiceProvider);
}
