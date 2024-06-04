import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/launch/provider/launch_view_provider.dart';
import 'package:obfuscation_controller/config/app_config.dart';
import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';

class LaunchViewApplicationNameText extends ConsumerWidget {
  const LaunchViewApplicationNameText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchViewState = ref.watch(LaunchViewProvider.launchViewProvider);

    return AnimatedOpacity(
      opacity: launchViewState.lottieAnimationState == true ? 1 : 0,
      duration: const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS),
      child: Text(
        AppConfig.environment.getApplicationName(ref: ref),
        textAlign: TextAlign.center,
        style: context.appTextStyles.xlargeTextWithTransparentBackground,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
