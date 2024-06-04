import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/loading/controller/loading_controller.dart';

class LoadingProvider {
  const LoadingProvider._();

  /// Provider for [LoadingController].
  static final loadingControllerProvider = StateNotifierProvider<LoadingController, LoadingState>((ref) {
    return LoadingController();
  });
}
