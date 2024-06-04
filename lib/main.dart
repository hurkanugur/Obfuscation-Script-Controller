import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/loading/provider/loading_provider.dart';
import 'package:obfuscation_controller/app/presentation/loading/widget/loading_lottie_animation.dart';
import 'package:obfuscation_controller/config/app_config.dart';
import 'package:obfuscation_controller/core/localization/enum/language_type.dart';
import 'package:obfuscation_controller/core/localization/provider/localization_provider.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';
import 'package:obfuscation_controller/core/storage/provider/storage_provider.dart';
import 'package:obfuscation_controller/core/storage/service/shares_preference_service.dart';
import 'package:obfuscation_controller/core/theme/constants/dark_theme_constants.dart';
import 'package:obfuscation_controller/core/theme/constants/light_theme_constants.dart';
import 'package:obfuscation_controller/core/theme/provider/theme_provider.dart';
import 'package:obfuscation_controller/environment/enum/flavor_type.dart';
import 'package:obfuscation_controller/environment/model/flavor_config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // TODO: Delete this manually set environment variable in the future.
  AppConfig.environment = const FlavorConfigModel(
    flavorType: FlavorType.dev,
    appNameTag: ' (DEV)',
  );

  WidgetsFlutterBinding.ensureInitialized();

  final ProviderContainer providerContainer = ProviderContainer();

  final SharedPreferenceService sharedPreferenceService = SharedPreferenceService(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  final localizationController = providerContainer.read(LocalizationProvider.localizationControllerProvider.notifier);
  await localizationController.changeLanguage(
    languageType: sharedPreferenceService.getLanguageType(),
    ref: null,
  );

  final themeController = providerContainer.read(ThemeProvider.themeControllerProvider.notifier);
  themeController.changeTheme(
    themeMode: sharedPreferenceService.getThemeMode(),
    ref: null,
  );

  runApp(
    ProviderScope(
      overrides: [
        StorageProvider.sharedPreferenceServiceProvider.overrideWithValue(sharedPreferenceService),
        LocalizationProvider.localizationControllerProvider.overrideWith((ref) => localizationController),
        ThemeProvider.themeControllerProvider.overrideWith((ref) => themeController),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(LoadingProvider.loadingControllerProvider);
    final localizationState = ref.watch(LocalizationProvider.localizationControllerProvider);
    final themeState = ref.watch(ThemeProvider.themeControllerProvider);

    return LoadingLottieAnimation(
      isLoading: loadingState.isLoading,
      child: MaterialApp.router(
        title: AppConfig.environment.getApplicationName(ref: ref),
        themeMode: themeState.themeMode,
        theme: LightThemeConstants.themeData,
        darkTheme: DarkThemeConstants.themeData,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Localizations.override(
            context: context,
            locale: localizationState.languageType.getLocale(),
            child: child,
          ),
        ),
        supportedLocales: LanguageType.values.map((e) => e.getLocale()),
        locale: localizationState.languageType.getLocale(),
        debugShowCheckedModeBanner: false,
        routerConfig: RouterExtension.goRouter,
      ),
    );
  }
}
