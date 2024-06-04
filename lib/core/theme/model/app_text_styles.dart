import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  // Transparent Text Colors
  final TextStyle? smallTextWithTransparentBackground;
  final TextStyle? smallBoldTextWithTransparentBackground;
  final TextStyle? mediumTextWithTransparentBackground;
  final TextStyle? mediumBoldTextWithTransparentBackground;
  final TextStyle? largeTextWithTransparentBackground;
  final TextStyle? largeBoldTextWithTransparentBackground;
  final TextStyle? xlargeTextWithTransparentBackground;
  final TextStyle? xlargeBoldTextWithTransparentBackground;

  // Filled Text Colors
  final TextStyle? smallTextWithFilledBackground;
  final TextStyle? smallBoldTextWithFilledBackground;
  final TextStyle? mediumTextWithFilledBackground;
  final TextStyle? mediumBoldTextWithFilledBackground;
  final TextStyle? largeTextWithFilledBackground;
  final TextStyle? largeBoldTextWithFilledBackground;
  final TextStyle? xlargeTextWithFilledBackground;
  final TextStyle? xlargeBoldTextWithFilledBackground;

  // Disabled Transparent Text Colors
  final TextStyle? smallDisabledTextWithTransparentBackground;
  final TextStyle? smallBoldDisabledTextWithTransparentBackground;
  final TextStyle? mediumDisabledTextWithTransparentBackground;
  final TextStyle? mediumBoldDisabledTextWithTransparentBackground;
  final TextStyle? largeDisabledTextWithTransparentBackground;
  final TextStyle? largeBoldDisabledTextWithTransparentBackground;
  final TextStyle? xlargeDisabledTextWithTransparentBackground;
  final TextStyle? xlargeBoldDisabledTextWithTransparentBackground;

  // Disabled Filled Text Colors
  final TextStyle? smallDisabledTextWithFilledBackground;
  final TextStyle? smallBoldDisabledTextWithFilledBackground;
  final TextStyle? mediumDisabledTextWithFilledBackground;
  final TextStyle? mediumBoldDisabledTextWithFilledBackground;
  final TextStyle? largeDisabledTextWithFilledBackground;
  final TextStyle? largeBoldDisabledTextWithFilledBackground;
  final TextStyle? xlargeDisabledTextWithFilledBackground;
  final TextStyle? xlargeBoldDisabledTextWithFilledBackground;

  // Info Text Colors
  final TextStyle? smallInfoText;
  final TextStyle? smallInfoBoldText;
  final TextStyle? mediumInfoText;
  final TextStyle? mediumInfoBoldText;
  final TextStyle? largeInfoText;
  final TextStyle? largeInfoBoldText;
  final TextStyle? xlargeInfoText;
  final TextStyle? xlargeInfoBoldText;

  // Warning Text Colors
  final TextStyle? smallWarningText;
  final TextStyle? smallWarningBoldText;
  final TextStyle? mediumWarningText;
  final TextStyle? mediumWarningBoldText;
  final TextStyle? largeWarningText;
  final TextStyle? largeWarningBoldText;
  final TextStyle? xlargeWarningText;
  final TextStyle? xlargeWarningBoldText;

  // Error Text Colors
  final TextStyle? smallErrorText;
  final TextStyle? smallErrorBoldText;
  final TextStyle? mediumErrorText;
  final TextStyle? mediumErrorBoldText;
  final TextStyle? largeErrorText;
  final TextStyle? largeErrorBoldText;
  final TextStyle? xlargeErrorText;
  final TextStyle? xlargeErrorBoldText;

  const AppTextStyles({
    // Transparent Text Colors
    required this.smallTextWithTransparentBackground,
    required this.smallBoldTextWithTransparentBackground,
    required this.mediumTextWithTransparentBackground,
    required this.mediumBoldTextWithTransparentBackground,
    required this.largeTextWithTransparentBackground,
    required this.largeBoldTextWithTransparentBackground,
    required this.xlargeTextWithTransparentBackground,
    required this.xlargeBoldTextWithTransparentBackground,
    // Filled Text Colors
    required this.smallTextWithFilledBackground,
    required this.smallBoldTextWithFilledBackground,
    required this.mediumTextWithFilledBackground,
    required this.mediumBoldTextWithFilledBackground,
    required this.largeTextWithFilledBackground,
    required this.largeBoldTextWithFilledBackground,
    required this.xlargeTextWithFilledBackground,
    required this.xlargeBoldTextWithFilledBackground,
    // Disabled Transparent Text Colors
    required this.smallDisabledTextWithTransparentBackground,
    required this.smallBoldDisabledTextWithTransparentBackground,
    required this.mediumDisabledTextWithTransparentBackground,
    required this.mediumBoldDisabledTextWithTransparentBackground,
    required this.largeDisabledTextWithTransparentBackground,
    required this.largeBoldDisabledTextWithTransparentBackground,
    required this.xlargeDisabledTextWithTransparentBackground,
    required this.xlargeBoldDisabledTextWithTransparentBackground,
    // Disabled Filled Text Colors
    required this.smallDisabledTextWithFilledBackground,
    required this.smallBoldDisabledTextWithFilledBackground,
    required this.mediumDisabledTextWithFilledBackground,
    required this.mediumBoldDisabledTextWithFilledBackground,
    required this.largeDisabledTextWithFilledBackground,
    required this.largeBoldDisabledTextWithFilledBackground,
    required this.xlargeDisabledTextWithFilledBackground,
    required this.xlargeBoldDisabledTextWithFilledBackground,
    // Info Text Colors
    required this.smallInfoText,
    required this.smallInfoBoldText,
    required this.mediumInfoText,
    required this.mediumInfoBoldText,
    required this.largeInfoText,
    required this.largeInfoBoldText,
    required this.xlargeInfoText,
    required this.xlargeInfoBoldText,
    // Warning Text Colors
    required this.smallWarningText,
    required this.smallWarningBoldText,
    required this.mediumWarningText,
    required this.mediumWarningBoldText,
    required this.largeWarningText,
    required this.largeWarningBoldText,
    required this.xlargeWarningText,
    required this.xlargeWarningBoldText,
    // Error Text Colors
    required this.smallErrorText,
    required this.smallErrorBoldText,
    required this.mediumErrorText,
    required this.mediumErrorBoldText,
    required this.largeErrorText,
    required this.largeErrorBoldText,
    required this.xlargeErrorText,
    required this.xlargeErrorBoldText,
  });

  @override
  AppTextStyles copyWith({
    // Transparent Text Colors
    TextStyle? smallTextWithTransparentBackground,
    TextStyle? smallBoldTextWithTransparentBackground,
    TextStyle? mediumTextWithTransparentBackground,
    TextStyle? mediumBoldTextWithTransparentBackground,
    TextStyle? largeTextWithTransparentBackground,
    TextStyle? largeBoldTextWithTransparentBackground,
    TextStyle? xlargeTextWithTransparentBackground,
    TextStyle? xlargeBoldTextWithTransparentBackground,
    // Filled Text Colors
    TextStyle? smallTextWithFilledBackground,
    TextStyle? smallBoldTextWithFilledBackground,
    TextStyle? mediumTextWithFilledBackground,
    TextStyle? mediumBoldTextWithFilledBackground,
    TextStyle? largeTextWithFilledBackground,
    TextStyle? largeBoldTextWithFilledBackground,
    TextStyle? xlargeTextWithFilledBackground,
    TextStyle? xlargeBoldTextWithFilledBackground,
    // Disabled Transparent Text Colors
    TextStyle? smallDisabledTextWithTransparentBackground,
    TextStyle? smallBoldDisabledTextWithTransparentBackground,
    TextStyle? mediumDisabledTextWithTransparentBackground,
    TextStyle? mediumBoldDisabledTextWithTransparentBackground,
    TextStyle? largeDisabledTextWithTransparentBackground,
    TextStyle? largeBoldDisabledTextWithTransparentBackground,
    TextStyle? xlargeDisabledTextWithTransparentBackground,
    TextStyle? xlargeBoldDisabledTextWithTransparentBackground,
    // Disabled Filled Text Colors
    TextStyle? smallDisabledTextWithFilledBackground,
    TextStyle? smallBoldDisabledTextWithFilledBackground,
    TextStyle? mediumDisabledTextWithFilledBackground,
    TextStyle? mediumBoldDisabledTextWithFilledBackground,
    TextStyle? largeDisabledTextWithFilledBackground,
    TextStyle? largeBoldDisabledTextWithFilledBackground,
    TextStyle? xlargeDisabledTextWithFilledBackground,
    TextStyle? xlargeBoldDisabledTextWithFilledBackground,
    // Info Text Colors
    TextStyle? smallInfoText,
    TextStyle? smallInfoBoldText,
    TextStyle? mediumInfoText,
    TextStyle? mediumInfoBoldText,
    TextStyle? largeInfoText,
    TextStyle? largeInfoBoldText,
    TextStyle? xlargeInfoText,
    TextStyle? xlargeInfoBoldText,
    // Warning Text Colors
    TextStyle? smallWarningText,
    TextStyle? smallWarningBoldText,
    TextStyle? mediumWarningText,
    TextStyle? mediumWarningBoldText,
    TextStyle? largeWarningText,
    TextStyle? largeWarningBoldText,
    TextStyle? xlargeWarningText,
    TextStyle? xlargeWarningBoldText,
    // Error Text Colors
    TextStyle? smallErrorText,
    TextStyle? smallErrorBoldText,
    TextStyle? mediumErrorText,
    TextStyle? mediumErrorBoldText,
    TextStyle? largeErrorText,
    TextStyle? largeErrorBoldText,
    TextStyle? xlargeErrorText,
    TextStyle? xlargeErrorBoldText,
  }) {
    return AppTextStyles(
      // Transparent Text Colors
      smallTextWithTransparentBackground: smallTextWithTransparentBackground ?? this.smallTextWithTransparentBackground,
      smallBoldTextWithTransparentBackground: smallBoldTextWithTransparentBackground ?? this.smallBoldTextWithTransparentBackground,
      mediumTextWithTransparentBackground: mediumTextWithTransparentBackground ?? this.mediumTextWithTransparentBackground,
      mediumBoldTextWithTransparentBackground: mediumBoldTextWithTransparentBackground ?? this.mediumBoldTextWithTransparentBackground,
      largeTextWithTransparentBackground: largeTextWithTransparentBackground ?? this.largeTextWithTransparentBackground,
      largeBoldTextWithTransparentBackground: largeBoldTextWithTransparentBackground ?? this.largeBoldTextWithTransparentBackground,
      xlargeTextWithTransparentBackground: xlargeTextWithTransparentBackground ?? this.xlargeTextWithTransparentBackground,
      xlargeBoldTextWithTransparentBackground: xlargeBoldTextWithTransparentBackground ?? this.xlargeBoldTextWithTransparentBackground,
      // Filled Text Colors
      smallTextWithFilledBackground: smallTextWithFilledBackground ?? this.smallTextWithFilledBackground,
      smallBoldTextWithFilledBackground: smallBoldTextWithFilledBackground ?? this.smallBoldTextWithFilledBackground,
      mediumTextWithFilledBackground: mediumTextWithFilledBackground ?? this.mediumTextWithFilledBackground,
      mediumBoldTextWithFilledBackground: mediumBoldTextWithFilledBackground ?? this.mediumBoldTextWithFilledBackground,
      largeTextWithFilledBackground: largeTextWithFilledBackground ?? this.largeTextWithFilledBackground,
      largeBoldTextWithFilledBackground: largeBoldTextWithFilledBackground ?? this.largeBoldTextWithFilledBackground,
      xlargeTextWithFilledBackground: xlargeTextWithFilledBackground ?? this.xlargeTextWithFilledBackground,
      xlargeBoldTextWithFilledBackground: xlargeBoldTextWithFilledBackground ?? this.xlargeBoldTextWithFilledBackground,
      // Disabled Transparent Text Colors
      smallDisabledTextWithTransparentBackground: smallDisabledTextWithTransparentBackground ?? this.smallDisabledTextWithTransparentBackground,
      smallBoldDisabledTextWithTransparentBackground: smallBoldDisabledTextWithTransparentBackground ?? this.smallBoldDisabledTextWithTransparentBackground,
      mediumDisabledTextWithTransparentBackground: mediumDisabledTextWithTransparentBackground ?? this.mediumDisabledTextWithTransparentBackground,
      mediumBoldDisabledTextWithTransparentBackground: mediumBoldDisabledTextWithTransparentBackground ?? this.mediumBoldDisabledTextWithTransparentBackground,
      largeDisabledTextWithTransparentBackground: largeDisabledTextWithTransparentBackground ?? this.largeDisabledTextWithTransparentBackground,
      largeBoldDisabledTextWithTransparentBackground: largeBoldDisabledTextWithTransparentBackground ?? this.largeBoldDisabledTextWithTransparentBackground,
      xlargeDisabledTextWithTransparentBackground: xlargeDisabledTextWithTransparentBackground ?? this.xlargeDisabledTextWithTransparentBackground,
      xlargeBoldDisabledTextWithTransparentBackground: xlargeBoldDisabledTextWithTransparentBackground ?? this.xlargeBoldDisabledTextWithTransparentBackground,
      // Disabled Filled Text Colors
      smallDisabledTextWithFilledBackground: smallDisabledTextWithFilledBackground ?? this.smallDisabledTextWithFilledBackground,
      smallBoldDisabledTextWithFilledBackground: smallBoldDisabledTextWithFilledBackground ?? this.smallBoldDisabledTextWithFilledBackground,
      mediumDisabledTextWithFilledBackground: mediumDisabledTextWithFilledBackground ?? this.mediumDisabledTextWithFilledBackground,
      mediumBoldDisabledTextWithFilledBackground: mediumBoldDisabledTextWithFilledBackground ?? this.mediumBoldDisabledTextWithFilledBackground,
      largeDisabledTextWithFilledBackground: largeDisabledTextWithFilledBackground ?? this.largeDisabledTextWithFilledBackground,
      largeBoldDisabledTextWithFilledBackground: largeBoldDisabledTextWithFilledBackground ?? this.largeBoldDisabledTextWithFilledBackground,
      xlargeDisabledTextWithFilledBackground: xlargeDisabledTextWithFilledBackground ?? this.xlargeDisabledTextWithFilledBackground,
      xlargeBoldDisabledTextWithFilledBackground: xlargeBoldDisabledTextWithFilledBackground ?? this.xlargeBoldDisabledTextWithFilledBackground,
      // Info Text Colors
      smallInfoText: smallInfoText ?? this.smallInfoText,
      smallInfoBoldText: smallInfoBoldText ?? this.smallInfoBoldText,
      mediumInfoText: mediumInfoText ?? this.mediumInfoText,
      mediumInfoBoldText: mediumInfoBoldText ?? this.mediumInfoBoldText,
      largeInfoText: largeInfoText ?? this.largeInfoText,
      largeInfoBoldText: largeInfoBoldText ?? this.largeInfoBoldText,
      xlargeInfoText: xlargeInfoText ?? this.xlargeInfoText,
      xlargeInfoBoldText: xlargeInfoBoldText ?? this.xlargeInfoBoldText,
      // Warning Text Colors
      smallWarningText: smallWarningText ?? this.smallWarningText,
      smallWarningBoldText: smallWarningBoldText ?? this.smallWarningBoldText,
      mediumWarningText: mediumWarningText ?? this.mediumWarningText,
      mediumWarningBoldText: mediumWarningBoldText ?? this.mediumWarningBoldText,
      largeWarningText: largeWarningText ?? this.largeWarningText,
      largeWarningBoldText: largeWarningBoldText ?? this.largeWarningBoldText,
      xlargeWarningText: xlargeWarningText ?? this.xlargeWarningText,
      xlargeWarningBoldText: xlargeWarningBoldText ?? this.xlargeWarningBoldText,
      // Error Text Colors
      smallErrorText: smallErrorText ?? this.smallErrorText,
      smallErrorBoldText: smallErrorBoldText ?? this.smallErrorBoldText,
      mediumErrorText: mediumErrorText ?? this.mediumErrorText,
      mediumErrorBoldText: mediumErrorBoldText ?? this.mediumErrorBoldText,
      largeErrorText: largeErrorText ?? this.largeErrorText,
      largeErrorBoldText: largeErrorBoldText ?? this.largeErrorBoldText,
      xlargeErrorText: xlargeErrorText ?? this.xlargeErrorText,
      xlargeErrorBoldText: xlargeErrorBoldText ?? this.xlargeErrorBoldText,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(covariant ThemeExtension<AppTextStyles>? other, double t) {
    if (other == null || other is! AppTextStyles) {
      return this;
    }

    return AppTextStyles(
      // Transparent Text Colors
      smallTextWithTransparentBackground: TextStyle.lerp(smallTextWithTransparentBackground, other.smallTextWithTransparentBackground, t),
      smallBoldTextWithTransparentBackground: TextStyle.lerp(smallBoldTextWithTransparentBackground, other.smallBoldTextWithTransparentBackground, t),
      mediumTextWithTransparentBackground: TextStyle.lerp(mediumTextWithTransparentBackground, other.mediumTextWithTransparentBackground, t),
      mediumBoldTextWithTransparentBackground: TextStyle.lerp(mediumBoldTextWithTransparentBackground, other.mediumBoldTextWithTransparentBackground, t),
      largeTextWithTransparentBackground: TextStyle.lerp(largeTextWithTransparentBackground, other.largeTextWithTransparentBackground, t),
      largeBoldTextWithTransparentBackground: TextStyle.lerp(largeBoldTextWithTransparentBackground, other.largeBoldTextWithTransparentBackground, t),
      xlargeTextWithTransparentBackground: TextStyle.lerp(xlargeTextWithTransparentBackground, other.xlargeTextWithTransparentBackground, t),
      xlargeBoldTextWithTransparentBackground: TextStyle.lerp(xlargeBoldTextWithTransparentBackground, other.xlargeBoldTextWithTransparentBackground, t),
      // Filled Text Colors
      smallTextWithFilledBackground: TextStyle.lerp(smallTextWithFilledBackground, other.smallTextWithFilledBackground, t),
      smallBoldTextWithFilledBackground: TextStyle.lerp(smallBoldTextWithFilledBackground, other.smallBoldTextWithFilledBackground, t),
      mediumTextWithFilledBackground: TextStyle.lerp(mediumTextWithFilledBackground, other.mediumTextWithFilledBackground, t),
      mediumBoldTextWithFilledBackground: TextStyle.lerp(mediumBoldTextWithFilledBackground, other.mediumBoldTextWithFilledBackground, t),
      largeTextWithFilledBackground: TextStyle.lerp(largeTextWithFilledBackground, other.largeTextWithFilledBackground, t),
      largeBoldTextWithFilledBackground: TextStyle.lerp(largeBoldTextWithFilledBackground, other.largeBoldTextWithFilledBackground, t),
      xlargeTextWithFilledBackground: TextStyle.lerp(xlargeTextWithFilledBackground, other.xlargeTextWithFilledBackground, t),
      xlargeBoldTextWithFilledBackground: TextStyle.lerp(xlargeBoldTextWithFilledBackground, other.xlargeBoldTextWithFilledBackground, t),
      // Disabled Transparent Text Colors
      smallDisabledTextWithTransparentBackground: TextStyle.lerp(smallDisabledTextWithTransparentBackground, other.smallDisabledTextWithTransparentBackground, t),
      smallBoldDisabledTextWithTransparentBackground: TextStyle.lerp(smallBoldDisabledTextWithTransparentBackground, other.smallBoldDisabledTextWithTransparentBackground, t),
      mediumDisabledTextWithTransparentBackground: TextStyle.lerp(mediumDisabledTextWithTransparentBackground, other.mediumDisabledTextWithTransparentBackground, t),
      mediumBoldDisabledTextWithTransparentBackground: TextStyle.lerp(mediumBoldDisabledTextWithTransparentBackground, other.mediumBoldDisabledTextWithTransparentBackground, t),
      largeDisabledTextWithTransparentBackground: TextStyle.lerp(largeDisabledTextWithTransparentBackground, other.largeDisabledTextWithTransparentBackground, t),
      largeBoldDisabledTextWithTransparentBackground: TextStyle.lerp(largeBoldDisabledTextWithTransparentBackground, other.largeBoldDisabledTextWithTransparentBackground, t),
      xlargeDisabledTextWithTransparentBackground: TextStyle.lerp(xlargeDisabledTextWithTransparentBackground, other.xlargeDisabledTextWithTransparentBackground, t),
      xlargeBoldDisabledTextWithTransparentBackground: TextStyle.lerp(xlargeBoldDisabledTextWithTransparentBackground, other.xlargeBoldDisabledTextWithTransparentBackground, t),
      // Disabled Filled Text Colors
      smallDisabledTextWithFilledBackground: TextStyle.lerp(smallDisabledTextWithFilledBackground, other.smallDisabledTextWithFilledBackground, t),
      smallBoldDisabledTextWithFilledBackground: TextStyle.lerp(smallBoldDisabledTextWithFilledBackground, other.smallBoldDisabledTextWithFilledBackground, t),
      mediumDisabledTextWithFilledBackground: TextStyle.lerp(mediumDisabledTextWithFilledBackground, other.mediumDisabledTextWithFilledBackground, t),
      mediumBoldDisabledTextWithFilledBackground: TextStyle.lerp(mediumBoldDisabledTextWithFilledBackground, other.mediumBoldDisabledTextWithFilledBackground, t),
      largeDisabledTextWithFilledBackground: TextStyle.lerp(largeDisabledTextWithFilledBackground, other.largeDisabledTextWithFilledBackground, t),
      largeBoldDisabledTextWithFilledBackground: TextStyle.lerp(largeBoldDisabledTextWithFilledBackground, other.largeBoldDisabledTextWithFilledBackground, t),
      xlargeDisabledTextWithFilledBackground: TextStyle.lerp(xlargeDisabledTextWithFilledBackground, other.xlargeDisabledTextWithFilledBackground, t),
      xlargeBoldDisabledTextWithFilledBackground: TextStyle.lerp(xlargeBoldDisabledTextWithFilledBackground, other.xlargeBoldDisabledTextWithFilledBackground, t),
      // Info Text Colors
      smallInfoText: TextStyle.lerp(smallInfoText, other.smallInfoText, t),
      smallInfoBoldText: TextStyle.lerp(smallInfoBoldText, other.smallInfoBoldText, t),
      mediumInfoText: TextStyle.lerp(mediumInfoText, other.mediumInfoText, t),
      mediumInfoBoldText: TextStyle.lerp(mediumInfoBoldText, other.mediumInfoBoldText, t),
      largeInfoText: TextStyle.lerp(largeInfoText, other.largeInfoText, t),
      largeInfoBoldText: TextStyle.lerp(largeInfoBoldText, other.largeInfoBoldText, t),
      xlargeInfoText: TextStyle.lerp(xlargeInfoText, other.xlargeInfoText, t),
      xlargeInfoBoldText: TextStyle.lerp(xlargeInfoBoldText, other.xlargeInfoBoldText, t),
      // Warning Text Colors
      smallWarningText: TextStyle.lerp(smallWarningText, other.smallWarningText, t),
      smallWarningBoldText: TextStyle.lerp(smallWarningBoldText, other.smallWarningBoldText, t),
      mediumWarningText: TextStyle.lerp(mediumWarningText, other.mediumWarningText, t),
      mediumWarningBoldText: TextStyle.lerp(mediumWarningBoldText, other.mediumWarningBoldText, t),
      largeWarningText: TextStyle.lerp(largeWarningText, other.largeWarningText, t),
      largeWarningBoldText: TextStyle.lerp(largeWarningBoldText, other.largeWarningBoldText, t),
      xlargeWarningText: TextStyle.lerp(xlargeWarningText, other.xlargeWarningText, t),
      xlargeWarningBoldText: TextStyle.lerp(xlargeWarningBoldText, other.xlargeWarningBoldText, t),
      // Error Text Colors
      smallErrorText: TextStyle.lerp(smallErrorText, other.smallErrorText, t),
      smallErrorBoldText: TextStyle.lerp(smallErrorBoldText, other.smallErrorBoldText, t),
      mediumErrorText: TextStyle.lerp(mediumErrorText, other.mediumErrorText, t),
      mediumErrorBoldText: TextStyle.lerp(mediumErrorBoldText, other.mediumErrorBoldText, t),
      largeErrorText: TextStyle.lerp(largeErrorText, other.largeErrorText, t),
      largeErrorBoldText: TextStyle.lerp(largeErrorBoldText, other.largeErrorBoldText, t),
      xlargeErrorText: TextStyle.lerp(xlargeErrorText, other.xlargeErrorText, t),
      xlargeErrorBoldText: TextStyle.lerp(xlargeErrorBoldText, other.xlargeErrorBoldText, t),
    );
  }
}
