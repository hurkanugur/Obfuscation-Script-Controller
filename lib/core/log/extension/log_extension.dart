import 'package:flutter/foundation.dart';
import 'package:obfuscation_controller/config/app_strings.dart';
import 'package:obfuscation_controller/core/datetime/extension/date_extension.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';
import 'package:obfuscation_controller/core/error/model/failure.dart';
import 'package:obfuscation_controller/core/error/model/server_failure.dart';
import 'package:obfuscation_controller/core/localization/enum/language_type.dart';
import 'dart:developer' as developer;

import 'package:obfuscation_controller/core/localization/enum/text_type.dart';

extension LogExtension on StackTrace {
  /// Logs a success message.
  void printSuccessMessage({required TextType textType, dynamic data}) {
    if (!kDebugMode) {
      return;
    }

    String successMessage = AppStrings.emptyText;

    successMessage += '\n[ClassName]: ${findClassName()}';
    successMessage += '\n[MethodName]: ${findMethodName()}';
    successMessage += '\n[DateTime]: ${DateTime.now().toReadableDateTimeString(languageType: LanguageType.turkish)}';
    successMessage += '\n[Message]: $textType';
    successMessage += data == null ? '' : '\n[Data]: ${data?.toString() ?? AppStrings.emptyText}';

    developer.log(successMessage, name: 'SUCCESS', time: DateTime.now());
  }

  /// Logs an error message by [failure].
  void printErrorMessageByFailure({required Failure failure}) {
    if (!kDebugMode) {
      return;
    }

    String errorMessage = AppStrings.emptyText;

    errorMessage += '\n[ClassName]: ${findClassName()}';
    errorMessage += '\n[MethodName]: ${findMethodName()}';
    errorMessage += '\n[DateTime]: ${failure.dateTime.toReadableDateTimeString(languageType: LanguageType.turkish)}';

    if (failure is ServerFailure) {
      errorMessage += '\n[StatusCode]: ${failure.statusCode ?? AppStrings.emptyText}';
      errorMessage += '\n[ServerExceptionType]: ${failure.serverExceptionType}';
      errorMessage += '\n[ServerProblemType]: ${failure.serverProblemType}';
    } else if (failure is ClientFailure) {
      errorMessage += '\n[ClientExceptionType]: ${failure.clientExceptionType}';
    }

    errorMessage += failure.exception == null ? '' : '\n[ErrorMessage]: ${failure.exception?.toString() ?? AppStrings.emptyText}';
    developer.log(errorMessage, name: 'FAILURE', time: DateTime.now());
  }

  /// Finds the class name from the stack trace.
  String findClassName() {
    final RegExp regex = RegExp(r'#\d+\s+(.*?)\s+\(');
    final Match? match = regex.firstMatch(toString());

    String className = AppStrings.emptyText;

    if (match != null && match.groupCount >= 1) {
      final String? classAndMethodName = match.group(1);

      if (classAndMethodName != null) {
        final List<String> parts = classAndMethodName.split('.');
        if (parts.length >= 2) {
          className = parts[0];
        }
      }
    }

    return className;
  }

  /// Finds the method name from the stack trace.
  String findMethodName() {
    final RegExp regex = RegExp(r'#\d+\s+(.*?)\s+\(');
    final Match? match = regex.firstMatch(toString());

    String methodName = AppStrings.emptyText;

    if (match != null && match.groupCount >= 1) {
      final String? classAndMethodName = match.group(1);

      if (classAndMethodName != null) {
        final List<String> parts = classAndMethodName.split('.');
        if (parts.length >= 2) {
          methodName = parts[1];
        }
      }
    }

    return methodName;
  }
}
