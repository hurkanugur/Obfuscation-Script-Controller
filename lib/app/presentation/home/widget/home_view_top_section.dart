import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/loading/provider/loading_provider.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/config/app_icons.dart';
import 'package:obfuscation_controller/core/localization/enum/language_type.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/localization/provider/localization_provider.dart';
import 'package:obfuscation_controller/core/storage/extension/shared_preference_extension.dart';
import 'package:obfuscation_controller/core/theme/provider/theme_provider.dart';
import 'package:obfuscation_controller/core/widgets/advanced_button_with_icon.dart';
import 'package:obfuscation_controller/core/widgets/advanced_button_with_text.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_status_type.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_style_type.dart';

class HomeViewTopSection extends ConsumerWidget {
  const HomeViewTopSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final isEnglish = ref.sharedPreference.getLanguageType() == LanguageType.english;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: AppDimensions.widgetHeight,
          height: AppDimensions.widgetHeight,
          child: AdvancedTextButton(
            widgetStyleType: WidgetStyleType.transparent,
            widgetType: WidgetType.withTransparentParentWidget,
            title: isEnglish ? LanguageType.turkish.languageCode.toUpperCase() : LanguageType.english.languageCode.toUpperCase(),
            tooltip: isEnglish ? ref.translateText(textType: TextType.turkish) : ref.translateText(textType: TextType.english),
            onTap: () => _onLanguageButtonClicked(ref: ref, isEnglish: isEnglish),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: AppDimensions.widgetHeight,
          height: AppDimensions.widgetHeight,
          child: AdvancedIconButton(
            icon: isDarkTheme ? AppIcons.lightThemeIcon : AppIcons.darkThemeIcon,
            widgetStyleType: WidgetStyleType.transparent,
            widgetType: WidgetType.withTransparentParentWidget,
            tooltip: ref.translateText(
              textType: isDarkTheme ? TextType.lightTheme : TextType.darkTheme,
            ),
            onTap: () => _onThemeButtonClicked(ref: ref, isDarkTheme: isDarkTheme),
          ),
        ),
      ],
    );
  }

  Future<void> _onLanguageButtonClicked({required WidgetRef ref, required bool isEnglish}) async {
    final localizationController = ref.read(LocalizationProvider.localizationControllerProvider.notifier);
    final loadingController = ref.read(LoadingProvider.loadingControllerProvider.notifier);

    loadingController.isLoading = true;
    await Future.delayed(const Duration(milliseconds: 500));
    await localizationController.changeLanguage(
      languageType: isEnglish ? LanguageType.turkish : LanguageType.english,
      ref: ref,
    );
    loadingController.isLoading = false;
  }

  Future<void> _onThemeButtonClicked({required WidgetRef ref, required bool isDarkTheme}) async {
    final themeController = ref.read(ThemeProvider.themeControllerProvider.notifier);
    final loadingController = ref.read(LoadingProvider.loadingControllerProvider.notifier);

    loadingController.isLoading = true;
    themeController.changeTheme(
      themeMode: isDarkTheme ? ThemeMode.light : ThemeMode.dark,
      ref: ref,
    );
    loadingController.isLoading = false;
  }
}
