import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_strings.dart';
import 'package:obfuscation_controller/core/datetime/extension/date_extension.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/log/menu/provider/log_provider.dart';
import 'package:obfuscation_controller/core/storage/extension/shared_preference_extension.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_textfield.dart';

class LogDetailsMenuDateTimeTextField extends ConsumerWidget {
  const LogDetailsMenuDateTimeTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logDetailsMenuState = ref.watch(LogProvider.logDetailsMenuControllerProvider);

    if (logDetailsMenuState.dateTime == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ref.translateText(textType: TextType.date),
          style: context.appTextStyles.mediumBoldTextWithTransparentBackground,
        ),
        const SizedBox(height: 10),
        AdvancedTextField(
          title: AppStrings.emptyText,
          focusNode: FocusNode(),
          textEditingController: TextEditingController(
            text: logDetailsMenuState.dateTime?.toReadableDateTimeString(
              languageType: ref.sharedPreference.getLanguageType(),
            ),
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          isReadOnly: true,
        ),
      ],
    );
  }
}
