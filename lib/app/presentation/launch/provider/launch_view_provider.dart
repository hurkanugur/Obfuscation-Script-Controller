import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/launch/controller/launch_view_controller.dart';

class LaunchViewProvider {
  const LaunchViewProvider._();

  static final launchViewProvider = StateNotifierProvider<LaunchViewController, LaunchViewState>(
    (ref) => LaunchViewController(),
  );
}
