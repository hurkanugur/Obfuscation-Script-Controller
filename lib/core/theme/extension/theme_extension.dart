import 'package:flutter/material.dart';
import 'package:obfuscation_controller/core/theme/model/app_colors.dart';
import 'package:obfuscation_controller/core/theme/model/app_text_styles.dart';

extension ThemeExtension on BuildContext {
  /// A getter for [AppColors].
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  /// A getter for [AppTextStyles].
  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;
}
