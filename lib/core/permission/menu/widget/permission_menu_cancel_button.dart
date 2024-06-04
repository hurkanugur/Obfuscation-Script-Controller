import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_button_with_text.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_status_type.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_style_type.dart';

class PermissionMenuCancelButton extends ConsumerWidget {
  const PermissionMenuCancelButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdvancedTextButton(
      title: ref.translateText(textType: TextType.cancel),
      widgetType: WidgetType.error,
      widgetStyleType: WidgetStyleType.filled,
      onTap: () async => await _buttonOnTap(context: context),
    );
  }

  Future<void> _buttonOnTap({required BuildContext context}) async {
    context.goBack();
  }
}
