import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/animation/extension/animation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AdvancedLottieAnimation extends ConsumerStatefulWidget {
  final String lottieAnimationPath;
  final Future<void> Function()? lottieAnimationOnLoaded;
  final Future<void> Function()? lottieAnimationOnCompleted;
  final double? animationWidth;
  final double animationHeight;
  final double? containerWidth;
  final double? containerHeight;
  final double scale;
  final bool blurBackground;
  final bool repeat;
  final int lottieAnimationAppearanceDelayDurationMS;

  const AdvancedLottieAnimation({
    super.key,
    required this.lottieAnimationPath,
    required this.animationHeight,
    this.animationWidth,
    this.containerWidth,
    this.containerHeight,
    this.lottieAnimationOnLoaded,
    this.lottieAnimationOnCompleted,
    this.scale = 1,
    this.blurBackground = false,
    this.repeat = true,
    this.lottieAnimationAppearanceDelayDurationMS = AnimationConstants.lottieAnimationAppearanceDelayDurationMS,
  });

  /// Creates a copy of this class.
  AdvancedLottieAnimation copyWith({
    String? lottieAnimationPath,
    Future<void> Function()? lottieAnimationOnLoaded,
    Future<void> Function()? lottieAnimationOnCompleted,
    double? animationWidth,
    double? animationHeight,
    double? containerWidth,
    double? containerHeight,
    double? scale,
    bool? blurBackground,
    bool? repeat,
  }) {
    return AdvancedLottieAnimation(
      lottieAnimationPath: lottieAnimationPath ?? this.lottieAnimationPath,
      lottieAnimationOnLoaded: lottieAnimationOnLoaded ?? this.lottieAnimationOnLoaded,
      lottieAnimationOnCompleted: lottieAnimationOnCompleted ?? this.lottieAnimationOnCompleted,
      animationWidth: animationWidth ?? this.animationWidth,
      animationHeight: animationHeight ?? this.animationHeight,
      containerWidth: containerWidth ?? this.containerWidth,
      containerHeight: containerHeight ?? this.containerHeight,
      scale: scale ?? this.scale,
      blurBackground: blurBackground ?? this.blurBackground,
      repeat: repeat ?? this.repeat,
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdvancedLottieAnimationState();
}

class _AdvancedLottieAnimationState extends ConsumerState<AdvancedLottieAnimation> with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  bool isLottieVisible = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);

    Future.delayed(Duration(milliseconds: widget.lottieAnimationAppearanceDelayDurationMS), () {
      if (_animationController != null) {
        setState(() => isLottieVisible = true);
      }
    });

    _animationController?.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        if (widget.repeat) {
          _animationController?.repeat();
        } else {
          _animationController?.stop();
        }

        if (widget.lottieAnimationOnCompleted != null) {
          await widget.lottieAnimationOnCompleted!();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS),
      switchInCurve: AnimationConstants.lottieAnimationAppearanceCurve,
      switchOutCurve: AnimationConstants.lottieAnimationAppearanceCurve,
      transitionBuilder: (child, animation) => context.lottieSwitchAnimation(animation: animation, child: child),
      child: isLottieVisible ? _createLottieAnimation() : SizedBox(height: widget.animationHeight),
    );
  }

  /// Creates the lottie animation container.
  Widget _createLottieAnimation() {
    return Container(
      width: widget.containerWidth,
      height: widget.containerHeight,
      alignment: Alignment.center,
      color: widget.blurBackground ? Colors.black.withOpacity(0.6) : null,
      child: Transform.scale(
        scale: widget.scale,
        alignment: Alignment.center,
        child: Lottie.asset(
          widget.lottieAnimationPath,
          controller: _animationController,
          frameRate: FrameRate.max,
          backgroundLoading: true,
          fit: BoxFit.contain,
          width: widget.animationWidth,
          height: widget.animationHeight,
          frameBuilder: (context, child, composition) => context.lottieRenderingAnimation(context: context, child: child, composition: composition),
          onLoaded: (LottieComposition composition) => _lottieOnLoaded(
            composition: composition,
            animationController: _animationController,
          ),
        ),
      ),
    );
  }

  /// Represents the lottie on loaded event.
  void _lottieOnLoaded({required LottieComposition composition, required AnimationController? animationController}) async {
    if (widget.lottieAnimationOnLoaded != null) {
      await widget.lottieAnimationOnLoaded!();
    }
    animationController?.duration = composition.duration;
    animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.stop();
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }
}
