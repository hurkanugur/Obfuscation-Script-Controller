import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/permission/menu/controller/permission_menu_controller.dart';

class PermissionProvider {
  const PermissionProvider._();

  /// Provider for [PermissionMenuController].
  static final permissionMenuControllerProvider = StateNotifierProvider<PermissionMenuController, PermissionMenuState>((ref) {
    return PermissionMenuController();
  });
}
