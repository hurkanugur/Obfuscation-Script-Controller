import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:obfuscation_controller/app/presentation/launch/provider/launch_view_provider.dart';
import 'package:obfuscation_controller/config/app_resources.dart';
import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/router/enum/router_type.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';

class LaunchLottieAnimation extends ConsumerStatefulWidget {
  const LaunchLottieAnimation({super.key});

  @override
  ConsumerState<LaunchLottieAnimation> createState() => _LaunchLottieAnimationState();
}

class _LaunchLottieAnimationState extends ConsumerState<LaunchLottieAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        final launchScreenLottieController = ref.read(LaunchViewProvider.launchViewProvider.notifier);
        launchScreenLottieController.lottieAnimationState = false;
        Future.delayed(const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS)).then((_) {
          ref.context.goTo(routerType: RouterType.home);
          launchScreenLottieController.resetState();
          _controller.reset();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final launchViewState = ref.watch(LaunchViewProvider.launchViewProvider);

    return Center(
      child: AnimatedOpacity(
        opacity: launchViewState.lottieAnimationState == true ? 1 : 0,
        duration: const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Lottie.asset(
            AppResources.lottieLaunchScreenAnimationPath,
            frameRate: FrameRate.max,
            fit: BoxFit.contain,
            frameBuilder: (context, child, composition) {
              return AnimatedOpacity(
                opacity: composition == null ? 0 : 1,
                duration: const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS),
                curve: AnimationConstants.lottieAnimationAppearanceCurve,
                child: child,
              );
            },
            onLoaded: _lottieOnLoaded,
          ),
        ),
      ),
    );
  }

  Future<void> _lottieOnLoaded(LottieComposition composition) async {
    _controller.duration = composition.duration;
    _controller.forward();
  }
}
