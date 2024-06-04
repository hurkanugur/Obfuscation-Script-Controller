import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:obfuscation_controller/core/theme/model/app_colors.dart';
import 'package:obfuscation_controller/core/theme/model/app_text_styles.dart';

class LightThemeConstants {
  const LightThemeConstants._();

  // Theme Data
  static const String _fontFamily = 'Poppins';

  // Light Theme Color Palette
  static const Color lightColor = Color(0xFFFAFAFA);
  static const Color darkBlueColor = Color.fromARGB(255, 5, 70, 123);
  static const Color blueColor = Color.fromARGB(255, 10, 85, 146);
  static const Color redColor = Color(0xFFB00020);
  static const Color orangeColor = Color(0xFFD18616);
  static const Color lightGrayColor = Color(0xFFCFD8DC);
  static const Color darkGrayColor = Color(0xFF90A4AE);
  static const Color barrierColor = kCupertinoModalBarrierColor;
  static const Color transparentColor = Colors.transparent;

  // Font Sizes
  static const double smallFontSize = 12.0;
  static const double mediumFontSize = 16.0;
  static const double largeFontSize = 20.0;
  static const double xlargeFontSize = 24.0;

  static const AppColors appColors = AppColors(
    // General Colors
    scaffoldBackgroundColor: lightColor,
    appBarBackgroundColor: lightColor,
    navigationBarBackgroundColor: lightColor,
    navigationRailBackgroundColor: lightColor,
    floatingActionButtonBackgroundColor: blueColor,
    drawerBackgroundColor: lightColor,
    dividerColor: lightGrayColor,
    lottieLoadingBackgroundColor: barrierColor,
    menuBarrierBackgroundColor: barrierColor,
    // Transparent Widget Colors
    transparentWidgetBackgroundColor: transparentColor,
    transparentWidgetForegroundColor: darkBlueColor,
    transparentWidgetBorderColor: lightGrayColor,
    transparentWidgetSelectedBackgroundColor: transparentColor,
    transparentWidgetSelectedForegroundColor: blueColor,
    transparentWidgetSelectedBorderColor: blueColor,
    transparentWidgetUnselectedBackgroundColor: transparentColor,
    transparentWidgetUnselectedForegroundColor: darkBlueColor,
    transparentWidgetUnselectedBorderColor: lightGrayColor,
    transparentWidgetDisabledBackgroundColor: transparentColor,
    transparentWidgetDisabledForegroundColor: darkGrayColor,
    transparentWidgetDisabledBorderColor: lightGrayColor,
    // Filled Widget Colors
    filledWidgetBackgroundColor: darkBlueColor,
    filledWidgetForegroundColor: lightColor,
    filledWidgetBorderColor: lightGrayColor,
    filledWidgetSelectedBackgroundColor: blueColor,
    filledWidgetSelectedForegroundColor: lightColor,
    filledWidgetSelectedBorderColor: blueColor,
    filledWidgetUnselectedBackgroundColor: darkBlueColor,
    filledWidgetUnselectedForegroundColor: lightColor,
    filledWidgetUnselectedBorderColor: lightGrayColor,
    filledWidgetDisabledBackgroundColor: darkGrayColor,
    filledWidgetDisabledForegroundColor: lightColor,
    filledWidgetDisabledBorderColor: lightGrayColor,
    // Alert Colors
    informationColor: blueColor,
    warningColor: orangeColor,
    errorColor: redColor,
  );

  static const AppTextStyles appTextStyles = AppTextStyles(
    // Transparent Text Colors
    smallTextWithTransparentBackground: TextStyle(
      fontSize: smallFontSize,
      color: darkBlueColor,
      fontFamily: _fontFamily,
    ),
    smallBoldTextWithTransparentBackground: TextStyle(
      fontSize: smallFontSize,
      fontWeight: FontWeight.bold,
      color: darkBlueColor,
      fontFamily: _fontFamily,
    ),
    mediumTextWithTransparentBackground: TextStyle(
      fontSize: mediumFontSize,
      color: darkBlueColor,
      fontFamily: _fontFamily,
    ),
    mediumBoldTextWithTransparentBackground: TextStyle(
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold,
      color: darkBlueColor,
      fontFamily: _fontFamily,
    ),
    largeTextWithTransparentBackground: TextStyle(
      fontSize: largeFontSize,
      color: darkBlueColor,
      fontFamily: _fontFamily,
    ),
    largeBoldTextWithTransparentBackground: TextStyle(
      fontSize: largeFontSize,
      fontWeight: FontWeight.bold,
      color: darkBlueColor,
      fontFamily: _fontFamily,
    ),
    xlargeTextWithTransparentBackground: TextStyle(
      fontSize: xlargeFontSize,
      color: darkBlueColor,
      fontFamily: _fontFamily,
    ),
    xlargeBoldTextWithTransparentBackground: TextStyle(
      fontSize: xlargeFontSize,
      fontWeight: FontWeight.bold,
      color: darkBlueColor,
      fontFamily: _fontFamily,
    ),
    // Filled Text Colors
    smallTextWithFilledBackground: TextStyle(
      fontSize: smallFontSize,
      color: lightColor,
      fontFamily: _fontFamily,
    ),
    smallBoldTextWithFilledBackground: TextStyle(
      fontSize: smallFontSize,
      fontWeight: FontWeight.bold,
      color: lightColor,
      fontFamily: _fontFamily,
    ),
    mediumTextWithFilledBackground: TextStyle(
      fontSize: mediumFontSize,
      color: lightColor,
      fontFamily: _fontFamily,
    ),
    mediumBoldTextWithFilledBackground: TextStyle(
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold,
      color: lightColor,
      fontFamily: _fontFamily,
    ),
    largeTextWithFilledBackground: TextStyle(
      fontSize: largeFontSize,
      color: lightColor,
      fontFamily: _fontFamily,
    ),
    largeBoldTextWithFilledBackground: TextStyle(
      fontSize: largeFontSize,
      fontWeight: FontWeight.bold,
      color: lightColor,
      fontFamily: _fontFamily,
    ),
    xlargeTextWithFilledBackground: TextStyle(
      fontSize: xlargeFontSize,
      color: lightColor,
      fontFamily: _fontFamily,
    ),
    xlargeBoldTextWithFilledBackground: TextStyle(
      fontSize: xlargeFontSize,
      fontWeight: FontWeight.bold,
      color: lightColor,
      fontFamily: _fontFamily,
    ),
    // Disabled Transparent Text Colors
    smallDisabledTextWithTransparentBackground: TextStyle(
      fontSize: smallFontSize,
      color: darkGrayColor,
      fontFamily: _fontFamily,
    ),
    smallBoldDisabledTextWithTransparentBackground: TextStyle(
      fontSize: smallFontSize,
      fontWeight: FontWeight.bold,
      color: darkGrayColor,
      fontFamily: _fontFamily,
    ),
    mediumDisabledTextWithTransparentBackground: TextStyle(
      fontSize: mediumFontSize,
      color: darkGrayColor,
      fontFamily: _fontFamily,
    ),
    mediumBoldDisabledTextWithTransparentBackground: TextStyle(
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold,
      color: darkGrayColor,
      fontFamily: _fontFamily,
    ),
    largeDisabledTextWithTransparentBackground: TextStyle(
      fontSize: largeFontSize,
      color: darkGrayColor,
      fontFamily: _fontFamily,
    ),
    largeBoldDisabledTextWithTransparentBackground: TextStyle(
      fontSize: largeFontSize,
      fontWeight: FontWeight.bold,
      color: darkGrayColor,
      fontFamily: _fontFamily,
    ),
    xlargeDisabledTextWithTransparentBackground: TextStyle(
      fontSize: xlargeFontSize,
      color: darkGrayColor,
      fontFamily: _fontFamily,
    ),
    xlargeBoldDisabledTextWithTransparentBackground: TextStyle(
      fontSize: xlargeFontSize,
      fontWeight: FontWeight.bold,
      color: darkGrayColor,
      fontFamily: _fontFamily,
    ),
    // Disabled Filled Text Colors
    smallDisabledTextWithFilledBackground: TextStyle(
      fontSize: smallFontSize,
      color: lightGrayColor,
      fontFamily: _fontFamily,
    ),
    smallBoldDisabledTextWithFilledBackground: TextStyle(
      fontSize: smallFontSize,
      fontWeight: FontWeight.bold,
      color: lightGrayColor,
      fontFamily: _fontFamily,
    ),
    mediumDisabledTextWithFilledBackground: TextStyle(
      fontSize: mediumFontSize,
      color: lightGrayColor,
      fontFamily: _fontFamily,
    ),
    mediumBoldDisabledTextWithFilledBackground: TextStyle(
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold,
      color: lightGrayColor,
      fontFamily: _fontFamily,
    ),
    largeDisabledTextWithFilledBackground: TextStyle(
      fontSize: largeFontSize,
      color: lightGrayColor,
      fontFamily: _fontFamily,
    ),
    largeBoldDisabledTextWithFilledBackground: TextStyle(
      fontSize: largeFontSize,
      fontWeight: FontWeight.bold,
      color: lightGrayColor,
      fontFamily: _fontFamily,
    ),
    xlargeDisabledTextWithFilledBackground: TextStyle(
      fontSize: xlargeFontSize,
      color: lightGrayColor,
      fontFamily: _fontFamily,
    ),
    xlargeBoldDisabledTextWithFilledBackground: TextStyle(
      fontSize: xlargeFontSize,
      fontWeight: FontWeight.bold,
      color: lightGrayColor,
      fontFamily: _fontFamily,
    ),
    // Info Text Colors
    smallInfoText: TextStyle(
      fontSize: smallFontSize,
      color: blueColor,
      fontFamily: _fontFamily,
    ),
    smallInfoBoldText: TextStyle(
      fontSize: smallFontSize,
      fontWeight: FontWeight.bold,
      color: blueColor,
      fontFamily: _fontFamily,
    ),
    mediumInfoText: TextStyle(
      fontSize: mediumFontSize,
      color: blueColor,
      fontFamily: _fontFamily,
    ),
    mediumInfoBoldText: TextStyle(
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold,
      color: blueColor,
      fontFamily: _fontFamily,
    ),
    largeInfoText: TextStyle(
      fontSize: largeFontSize,
      color: blueColor,
      fontFamily: _fontFamily,
    ),
    largeInfoBoldText: TextStyle(
      fontSize: largeFontSize,
      fontWeight: FontWeight.bold,
      color: blueColor,
      fontFamily: _fontFamily,
    ),
    xlargeInfoText: TextStyle(
      fontSize: xlargeFontSize,
      color: blueColor,
      fontFamily: _fontFamily,
    ),
    xlargeInfoBoldText: TextStyle(
      fontSize: xlargeFontSize,
      fontWeight: FontWeight.bold,
      color: blueColor,
      fontFamily: _fontFamily,
    ),
    // Warning Text Colors
    smallWarningText: TextStyle(
      fontSize: smallFontSize,
      color: orangeColor,
      fontFamily: _fontFamily,
    ),
    smallWarningBoldText: TextStyle(
      fontSize: smallFontSize,
      fontWeight: FontWeight.bold,
      color: orangeColor,
      fontFamily: _fontFamily,
    ),
    mediumWarningText: TextStyle(
      fontSize: mediumFontSize,
      color: orangeColor,
      fontFamily: _fontFamily,
    ),
    mediumWarningBoldText: TextStyle(
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold,
      color: orangeColor,
      fontFamily: _fontFamily,
    ),
    largeWarningText: TextStyle(
      fontSize: largeFontSize,
      color: orangeColor,
      fontFamily: _fontFamily,
    ),
    largeWarningBoldText: TextStyle(
      fontSize: largeFontSize,
      fontWeight: FontWeight.bold,
      color: orangeColor,
      fontFamily: _fontFamily,
    ),
    xlargeWarningText: TextStyle(
      fontSize: xlargeFontSize,
      color: orangeColor,
      fontFamily: _fontFamily,
    ),
    xlargeWarningBoldText: TextStyle(
      fontSize: xlargeFontSize,
      fontWeight: FontWeight.bold,
      color: orangeColor,
      fontFamily: _fontFamily,
    ),
    // Error Text Colors
    smallErrorText: TextStyle(
      fontSize: smallFontSize,
      color: redColor,
      fontFamily: _fontFamily,
    ),
    smallErrorBoldText: TextStyle(
      fontSize: smallFontSize,
      fontWeight: FontWeight.bold,
      color: redColor,
      fontFamily: _fontFamily,
    ),
    mediumErrorText: TextStyle(
      fontSize: mediumFontSize,
      color: redColor,
      fontFamily: _fontFamily,
    ),
    mediumErrorBoldText: TextStyle(
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold,
      color: redColor,
      fontFamily: _fontFamily,
    ),
    largeErrorText: TextStyle(
      fontSize: largeFontSize,
      color: redColor,
      fontFamily: _fontFamily,
    ),
    largeErrorBoldText: TextStyle(
      fontSize: largeFontSize,
      fontWeight: FontWeight.bold,
      color: redColor,
      fontFamily: _fontFamily,
    ),
    xlargeErrorText: TextStyle(
      fontSize: xlargeFontSize,
      color: redColor,
      fontFamily: _fontFamily,
    ),
    xlargeErrorBoldText: TextStyle(
      fontSize: xlargeFontSize,
      fontWeight: FontWeight.bold,
      color: redColor,
      fontFamily: _fontFamily,
    ),
  );

  /// Theme data for the light mode.
  static final ThemeData themeData = ThemeData(
    fontFamily: _fontFamily,
    brightness: Brightness.light,
    extensions: const <ThemeExtension<dynamic>>[
      appColors,
      appTextStyles,
    ],
  );
}
