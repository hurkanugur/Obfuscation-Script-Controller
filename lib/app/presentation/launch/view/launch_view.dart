import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/launch/provider/launch_view_provider.dart';
import 'package:obfuscation_controller/app/presentation/launch/widget/application_name.dart';
import 'package:obfuscation_controller/app/presentation/launch/widget/launch_lottie_animation.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_pop_scope.dart';

class LaunchView extends ConsumerStatefulWidget {
  const LaunchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LaunchViewState();
}

class _LaunchViewState extends ConsumerState<LaunchView> {
  @override
  void initState() {
    super.initState();

    final launchViewController = ref.read(LaunchViewProvider.launchViewProvider.notifier);
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => launchViewController.lottieAnimationState = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedPopScope(
      onPopScope: () => _onDeviceBackButtonPressed(ref),
      child: Scaffold(
        backgroundColor: context.appColors.scaffoldBackgroundColor,
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ApplicationName(),
              Expanded(flex: 1, child: LaunchLottieAnimation()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onDeviceBackButtonPressed(WidgetRef ref) async {}
}
