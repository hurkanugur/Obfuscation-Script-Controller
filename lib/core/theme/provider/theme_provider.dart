import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/theme/controller/theme_controller.dart';

class ThemeProvider {
  const ThemeProvider._();

  /// Provider for [ThemeController].
  static final themeControllerProvider = StateNotifierProvider<ThemeController, ThemeState>((ref) {
    return ThemeController();
  });
}
