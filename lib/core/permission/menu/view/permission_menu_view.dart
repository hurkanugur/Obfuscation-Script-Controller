import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/loading/provider/loading_provider.dart';
import 'package:obfuscation_controller/core/permission/menu/provider/permission_provider.dart';
import 'package:obfuscation_controller/core/permission/menu/widget/permission_menu_cancel_button.dart';
import 'package:obfuscation_controller/core/permission/menu/widget/permission_menu_explanation_text.dart';
import 'package:obfuscation_controller/core/permission/menu/widget/permission_menu_lottie_animation.dart';
import 'package:obfuscation_controller/core/permission/menu/widget/permission_menu_open_settings_button.dart';
import 'package:obfuscation_controller/core/permission/menu/widget/permission_menu_title.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_dialog_template.dart';

class PermissionMenuView extends ConsumerWidget {
  const PermissionMenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdvancedDialogTemplate(
      onPopScope: () async => await _onDeviceBackButtonPressed(ref: ref),
      widgets: const [
        SizedBox(height: 20),
        PermissionMenuTitle(),
        SizedBox(height: 20),
        PermissionMenuLottieAnimation(),
        SizedBox(height: 20),
        PermissionMenuExplanationText(),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: PermissionMenuCancelButton()),
            SizedBox(width: 20),
            Expanded(child: PermissionMenuOpenSettingsButton()),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Future<void> _onDeviceBackButtonPressed({required WidgetRef ref}) async {
    final loadingController = ref.read(LoadingProvider.loadingControllerProvider.notifier);
    final permissionMenuController = ref.read(PermissionProvider.permissionMenuControllerProvider.notifier);

    if (!loadingController.isLoading) {
      permissionMenuController.resetState();
      ref.context.goBack();
    }
  }
}
