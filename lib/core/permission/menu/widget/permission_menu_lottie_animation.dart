import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_resources.dart';
import 'package:obfuscation_controller/core/widgets/advanced_lottie_animation.dart';

class PermissionMenuLottieAnimation extends ConsumerWidget {
  const PermissionMenuLottieAnimation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double lottieHeight = MediaQuery.sizeOf(context).shortestSide / 2;

    return AdvancedLottieAnimation(
      lottieAnimationPath: AppResources.lottiePermissionMenuAnimationPath,
      animationHeight: lottieHeight,
    );
  }
}
