import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/permission/menu/provider/permission_provider.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';

class PermissionMenuExplanationText extends ConsumerWidget {
  const PermissionMenuExplanationText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionMenuState = ref.watch(PermissionProvider.permissionMenuControllerProvider);

    if (permissionMenuState.explanation == null) {
      return const SizedBox();
    }

    return Text(
      ref.translateText(textType: permissionMenuState.explanation!),
      style: context.appTextStyles.mediumTextWithTransparentBackground,
      textAlign: TextAlign.center,
    );
  }
}
