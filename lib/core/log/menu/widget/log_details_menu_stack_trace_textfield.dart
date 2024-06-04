import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_strings.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/log/menu/provider/log_provider.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_textfield.dart';

class LogDetailsMenuStackTraceTextField extends ConsumerWidget {
  const LogDetailsMenuStackTraceTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logDetailsMenuState = ref.watch(LogProvider.logDetailsMenuControllerProvider);

    if (logDetailsMenuState.stackTrace == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ref.translateText(textType: TextType.stackTrace),
          style: context.appTextStyles.mediumBoldTextWithTransparentBackground,
        ),
        const SizedBox(height: 10),
        AdvancedTextField(
          title: AppStrings.emptyText,
          focusNode: FocusNode(),
          textEditingController: TextEditingController(text: logDetailsMenuState.stackTrace.toString()),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          isReadOnly: true,
        ),
      ],
    );
  }
}
