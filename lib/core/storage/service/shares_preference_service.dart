import 'package:flutter/material.dart';
import 'package:obfuscation_controller/config/app_config.dart';
import 'package:obfuscation_controller/core/localization/enum/language_type.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_mode_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const String _languageTypeKey = 'language_type';
  static const String _themeTypeKey = 'theme_type';

  final SharedPreferences _sharedPreferences;

  const SharedPreferenceService({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  /// Setter for [_languageTypeKey].
  Future<void> setLanguageType({required LanguageType languageType}) async {
    await _sharedPreferences.setInt(_languageTypeKey, languageType.index);
  }

  /// Getter for [_languageTypeKey].
  LanguageType getLanguageType() {
    final int? index = _sharedPreferences.getInt(_languageTypeKey);
    return LanguageType.getLanguageByIndex(index: index) ?? AppConfig.defaultLanguageType;
  }

  /// Setter for [_themeTypeKey].
  Future<void> setThemeMode({required ThemeMode themeMode}) async {
    await _sharedPreferences.setInt(_themeTypeKey, themeMode.index);
  }

  /// Getter for [_themeTypeKey].
  ThemeMode getThemeMode() {
    final int? index = _sharedPreferences.getInt(_themeTypeKey);
    return ThemeModeExtension.getThemeByIndex(index: index) ?? AppConfig.defaultThemeMode;
  }

  /// Deletes a key from the [_sharedPreferences].
  ///
  /// When [deleteALL] is `true`, it clears all key-value pairs from the [_sharedPreferences].
  Future<void> deleteFromSharedPreferences({
    bool deleteALL = false,
    bool deleteLanguageType = false,
    bool deleteThemeType = false,
  }) async {
    if (deleteALL == true) {
      await _sharedPreferences.clear();
      return;
    }

    if (deleteLanguageType == true) {
      await _sharedPreferences.remove(_languageTypeKey);
    }

    if (deleteThemeType == true) {
      await _sharedPreferences.remove(_themeTypeKey);
    }
  }
}
