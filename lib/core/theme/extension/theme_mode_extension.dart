import 'package:flutter/material.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';

extension ThemeModeExtension on ThemeMode {
  /// Creates a [ThemeMode] from [index].
  ///
  /// Returns `null` when the enum is not found.
  static ThemeMode? getThemeByIndex({required int? index}) {
    try {
      return ThemeMode.values.firstWhere((element) => element.index == index);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
    return null;
  }
}
