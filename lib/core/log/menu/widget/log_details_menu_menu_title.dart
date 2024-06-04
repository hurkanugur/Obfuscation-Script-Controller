import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';

class LogDetailsMenuTitle extends ConsumerWidget {
  const LogDetailsMenuTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.translateText(textType: TextType.logDetails),
      style: context.appTextStyles.largeBoldTextWithTransparentBackground,
    );
  }
}
