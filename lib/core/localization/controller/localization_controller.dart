import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_strings.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';
import 'package:obfuscation_controller/core/error/model/failure.dart';
import 'package:obfuscation_controller/core/localization/enum/language_type.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/storage/extension/shared_preference_extension.dart';

class LocalizationState {
  final LanguageType languageType;
  final Map<String, dynamic> translations;

  const LocalizationState({
    required this.translations,
    required this.languageType,
  });

  /// Creates a copy of this class.
  LocalizationState copyWith({
    LanguageType? languageType,
    Map<String, dynamic>? translations,
  }) {
    return LocalizationState(
      languageType: languageType ?? this.languageType,
      translations: translations ?? this.translations,
    );
  }
}

class LocalizationController extends StateNotifier<LocalizationState> {
  LocalizationController()
      : super(
          const LocalizationState(
            languageType: LanguageType.english,
            translations: {},
          ),
        );

  /// Getter for [languageType].
  LanguageType get languageType => state.languageType;

  /// Changes the language of the app.
  ///
  /// Throws a [ClientFailure] when an error occurs.
  Future<void> changeLanguage({required LanguageType languageType, required WidgetRef? ref}) async {
    try {
      final String translationJsonString = await rootBundle.loadString(languageType.translationFilePath);

      if (ref != null) {
        await ref.sharedPreference.setLanguageType(languageType: languageType);
      }

      state = LocalizationState(
        languageType: languageType,
        translations: json.decode(translationJsonString),
      );
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.translationUpdateError,
      );
    }
  }

  /// Translates the given [TextType].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  String translateText({required TextType textType}) {
    try {
      return state.translations['APPLICATION_TEXT']![textType.name];
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.translationNotFoundError,
      );
    }
    return 'APPLICATION_TEXT.${textType.name}';
  }

  /// Translates the given [Failure].
  String translateFailure({required Failure failure}) {
    try {
      if (failure is ClientFailure) {
        return state.translations['CLIENT_EXCEPTION']![failure.clientExceptionType.name];
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.translationNotFoundError,
      );

      if (failure is ClientFailure) {
        return 'CLIENT_EXCEPTION.${failure.clientExceptionType.name}';
      }
    }

    return AppStrings.unknownText;
  }
}
