import 'package:flutter/material.dart';
import 'package:obfuscation_controller/config/app_config.dart';
import 'package:obfuscation_controller/core/localization/enum/language_type.dart';
import 'package:obfuscation_controller/core/security/service/file_security_service.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_mode_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const String _encryptedUsernameKey = 'encrypted_username';
  static const String _languageTypeKey = 'language_type';
  static const String _themeTypeKey = 'theme_type';

  final FileSecurityService _fileSecurityService;
  final SharedPreferences _sharedPreferences;

  const SharedPreferenceService({
    required SharedPreferences sharedPreferences,
    required FileSecurityService fileSecurityService,
  })  : _sharedPreferences = sharedPreferences,
        _fileSecurityService = fileSecurityService;

  /// Setter for [_encryptedUsernameKey].
  Future<void> setEncryptedUsername({required String plaintextUsername}) async {
    final String? encryptedUsername = _fileSecurityService.encrypt(plainText: plaintextUsername).data;

    if (encryptedUsername == null) {
      await deleteFromSharedPreferences(deleteEncryptedUsername: true);
    } else {
      await _sharedPreferences.setString(_encryptedUsernameKey, encryptedUsername);
    }
  }

  /// Getter for [_encryptedUsernameKey].
  String getPlaintextUsername() {
    final String? encryptedUsername = _sharedPreferences.getString(_encryptedUsernameKey);

    if (encryptedUsername == null) {
      return AppConfig.defaultUsername;
    }

    final String? plaintextUsername = _fileSecurityService.decrypt(chiperText: encryptedUsername).data;
    return plaintextUsername ?? AppConfig.defaultUsername;
  }

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
    bool deleteEncryptedUsername = false,
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

    if (deleteEncryptedUsername == true) {
      await _sharedPreferences.remove(_encryptedUsernameKey);
    }
  }
}
