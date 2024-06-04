import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/permission/menu/provider/permission_provider.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_button_with_text.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_status_type.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_style_type.dart';

class PermissionMenuOpenSettingsButton extends ConsumerWidget {
  const PermissionMenuOpenSettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdvancedTextButton(
      title: ref.translateText(textType: TextType.openSettings),
      widgetStyleType: WidgetStyleType.filled,
      widgetType: WidgetType.withTransparentParentWidget,
      onTap: () async => await _buttonOnTap(ref: ref),
    );
  }

  Future<void> _buttonOnTap({required WidgetRef ref}) async {
    final permissionMenuController = ref.read(PermissionProvider.permissionMenuControllerProvider.notifier);

    if (permissionMenuController.onDonePressed != null) {
      await permissionMenuController.onDonePressed!();
    }

    if (ref.context.mounted) {
      ref.context.goBack();
    }
  }
}
