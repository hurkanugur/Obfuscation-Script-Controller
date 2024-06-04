import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/log/menu/controller/log_details_menu_controller.dart';

class LogProvider {
  const LogProvider._();

  /// Provider for [LogDetailsMenuController].
  static final logDetailsMenuControllerProvider = StateNotifierProvider<LogDetailsMenuController, LogDetailsMenuState>((ref) {
    return LogDetailsMenuController();
  });
}
