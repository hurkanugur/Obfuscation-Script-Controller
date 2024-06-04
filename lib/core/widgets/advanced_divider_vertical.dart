import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedVerticalDivider extends ConsumerWidget {
  const AdvancedVerticalDivider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VerticalDivider(
      width: 1,
      color: context.appColors.dividerColor,
    );
  }
}
