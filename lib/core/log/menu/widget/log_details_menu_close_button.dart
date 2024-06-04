import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_button_with_text.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_status_type.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_style_type.dart';

class LoginDetailsMenuCloseButton extends ConsumerWidget {
  const LoginDetailsMenuCloseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      child: AdvancedTextButton(
        widgetStyleType: WidgetStyleType.filled,
        widgetType: WidgetType.withTransparentParentWidget,
        title: ref.translateText(textType: TextType.close),
        onTap: () => _buttonOnPressed(context: context),
      ),
    );
  }

  Future<void> _buttonOnPressed({required BuildContext context}) async {
    context.goBack();
  }
}
