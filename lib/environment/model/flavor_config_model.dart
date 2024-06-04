import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/provider/localization_provider.dart';
import 'package:obfuscation_controller/environment/enum/flavor_type.dart';

class FlavorConfigModel {
  final FlavorType flavorType;
  final String appNameTag;

  const FlavorConfigModel({
    required this.flavorType,
    required this.appNameTag,
  });

  String getApplicationName({required WidgetRef ref}) {
    final localizationController = ref.watch(LocalizationProvider.localizationControllerProvider.notifier);
    return localizationController.translateText(textType: TextType.applicationName) + appNameTag;
  }

  bool isDevelopment() {
    return (flavorType == FlavorType.dev);
  }

  bool isStage() {
    return (flavorType == FlavorType.stage);
  }

  bool isProduction() {
    return (flavorType == FlavorType.prod);
  }
}
