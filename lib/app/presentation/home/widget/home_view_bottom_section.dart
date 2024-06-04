import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/home/provider/home_view_provider.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/router/enum/router_type.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_button_with_text.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_status_type.dart';
import 'package:obfuscation_controller/core/widgets/enum/widget_style_type.dart';

class HomeViewBottomSection extends ConsumerWidget {
  const HomeViewBottomSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewState = ref.watch(HomeViewProvider.homeViewProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 4,
          child: AdvancedTextButton(
            widgetStyleType: WidgetStyleType.filled,
            widgetType: WidgetType.error,
            title: ref.translateText(textType: TextType.clear),
            onTap: homeViewState.obfuscationFilePath.isEmpty && homeViewState.dependencyFolderPath.isEmpty ? null : () async => await _onClearButtonClicked(ref: ref),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 4,
          child: AdvancedTextButton(
            widgetStyleType: WidgetStyleType.filled,
            widgetType: WidgetType.success,
            title: ref.translateText(textType: TextType.start),
            onTap: homeViewState.obfuscationFilePath.isEmpty || homeViewState.dependencyFolderPath.isEmpty ? null : () async => await _onStartButtonClicked(ref: ref),
          ),
        ),
      ],
    );
  }

  Future<void> _onClearButtonClicked({required WidgetRef ref}) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    homeViewController.resetState();
  }

  Future<void> _onStartButtonClicked({required WidgetRef ref}) async {
    ref.context.goTo(routerType: RouterType.editor);
  }
}
