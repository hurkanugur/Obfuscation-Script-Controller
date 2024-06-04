import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/localization/controller/localization_controller.dart';

class LocalizationProvider {
  const LocalizationProvider._();

  /// Provider for [LocalizationController].
  static final localizationControllerProvider = StateNotifierProvider<LocalizationController, LocalizationState>((ref) {
    return LocalizationController();
  });
}
