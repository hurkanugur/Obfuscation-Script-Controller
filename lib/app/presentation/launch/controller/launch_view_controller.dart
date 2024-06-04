import 'package:flutter_riverpod/flutter_riverpod.dart';

class LaunchViewState {
  final bool lottieAnimationState;

  const LaunchViewState({
    required this.lottieAnimationState,
  });

  LaunchViewState copyWith({bool? lottieAnimationState}) {
    return LaunchViewState(
      lottieAnimationState: lottieAnimationState ?? this.lottieAnimationState,
    );
  }
}

class LaunchViewController extends StateNotifier<LaunchViewState> {
  LaunchViewController()
      : super(
          const LaunchViewState(lottieAnimationState: false),
        );

  /// Getter for [lottieAnimationState].
  bool get lottieAnimationState => state.lottieAnimationState;

  /// Setter for [lottieAnimationState].
  set lottieAnimationState(bool isEnabled) => state = state.copyWith(lottieAnimationState: isEnabled);

  void resetState() {
    state = const LaunchViewState(
      lottieAnimationState: false,
    );
  }
}
