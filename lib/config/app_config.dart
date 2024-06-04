import 'package:flutter/material.dart';
import 'package:obfuscation_controller/core/localization/enum/language_type.dart';
import 'package:obfuscation_controller/environment/model/flavor_config_model.dart';

class AppConfig {
  const AppConfig._();

  /// Represents the active environment.
  static late final FlavorConfigModel environment;

  /// Default language type.
  static const LanguageType defaultLanguageType = LanguageType.english;

  /// Default theme mode.
  static const ThemeMode defaultThemeMode = ThemeMode.system;
}
