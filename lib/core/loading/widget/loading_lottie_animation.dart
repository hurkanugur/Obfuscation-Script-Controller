import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_resources.dart';
import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/animation/extension/animation_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_lottie_animation.dart';

class LoadingLottieAnimation extends ConsumerWidget {
  final bool isLoading;
  final Widget child;

  const LoadingLottieAnimation({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double lottieHeight = MediaQuery.sizeOf(context).shortestSide / 2.0;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child,
        AnimatedSwitcher(
          duration: const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS),
          switchInCurve: AnimationConstants.lottieAnimationAppearanceCurve,
          switchOutCurve: AnimationConstants.lottieAnimationAppearanceCurve,
          transitionBuilder: (child, animation) => context.lottieSwitchAnimation(animation: animation, child: child),
          child: isLoading
              ? AdvancedLottieAnimation(
                  lottieAnimationPath: AppResources.lottieLoadingAnimationPath,
                  animationHeight: lottieHeight,
                  containerHeight: MediaQuery.sizeOf(context).height,
                  containerWidth: MediaQuery.sizeOf(context).width,
                  blurBackground: true,
                  lottieAnimationAppearanceDelayDurationMS: Duration.zero.inMilliseconds,
                )
              : null,
        ),
      ],
    );
  }
}
