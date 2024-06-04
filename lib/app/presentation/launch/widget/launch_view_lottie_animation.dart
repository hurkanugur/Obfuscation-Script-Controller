import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/launch/provider/launch_view_provider.dart';
import 'package:obfuscation_controller/config/app_resources.dart';
import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/widgets/advanced_lottie_animation.dart';
import 'package:obfuscation_controller/core/router/enum/router_type.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';

class LaunchViewLottieAnimation extends ConsumerWidget {
  const LaunchViewLottieAnimation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchViewState = ref.watch(LaunchViewProvider.launchViewProvider);

    return AnimatedOpacity(
      opacity: launchViewState.lottieAnimationState == true ? 1 : 0,
      duration: const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AdvancedLottieAnimation(
            lottieAnimationPath: AppResources.lottieLaunchScreenAnimationPath,
            animationHeight: MediaQuery.sizeOf(context).height,
            lottieAnimationOnCompleted: () async => await _onLottieAnimationCompleted(ref: ref),
          ),
        ),
      ),
    );
  }

  Future<void> _onLottieAnimationCompleted({required WidgetRef ref}) async {
    final launchScreenLottieController = ref.read(LaunchViewProvider.launchViewProvider.notifier);
    launchScreenLottieController.lottieAnimationState = false;
    Future.delayed(const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS)).then((_) {
      ref.context.goTo(routerType: RouterType.home);
      launchScreenLottieController.resetState();
    });
  }
}
