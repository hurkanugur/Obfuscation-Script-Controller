import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_strings.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/log/menu/provider/log_provider.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_textfield.dart';

class LogDetailsMenuLocalizedMessageTextField extends ConsumerWidget {
  const LogDetailsMenuLocalizedMessageTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logDetailsMenuState = ref.watch(LogProvider.logDetailsMenuControllerProvider);

    if (logDetailsMenuState.localizedMessage == null || logDetailsMenuState.localizedMessage!.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ref.translateText(textType: TextType.localizedMessage),
          style: context.appTextStyles.mediumBoldTextWithTransparentBackground,
        ),
        const SizedBox(height: 10),
        AdvancedTextField(
          title: AppStrings.emptyText,
          focusNode: FocusNode(),
          textEditingController: TextEditingController(text: logDetailsMenuState.localizedMessage),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          isReadOnly: true,
        ),
      ],
    );
  }
}
