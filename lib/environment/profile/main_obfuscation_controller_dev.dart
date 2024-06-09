import 'package:obfuscation_controller/config/app_config.dart';
import 'package:obfuscation_controller/environment/enum/flavor_type.dart';
import 'package:obfuscation_controller/environment/model/flavor_config_model.dart';
import 'package:obfuscation_controller/main.dart' as common;

void main() {
  AppConfig.environment = const FlavorConfigModel(
    flavorType: FlavorType.dev,
    appNameTag: ' (DEV)',
    bundleID: 'com.example.obfuscation_controller.dev',
  );

  common.main();
}
