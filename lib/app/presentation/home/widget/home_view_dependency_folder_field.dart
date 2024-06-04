import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/home/provider/home_view_provider.dart';
import 'package:obfuscation_controller/app/presentation/loading/provider/loading_provider.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_drag_and_drop_field.dart';

class HomeViewDependencyFolderField extends ConsumerWidget {
  const HomeViewDependencyFolderField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewState = ref.watch(HomeViewProvider.homeViewProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Text(
            '${ref.translateText(textType: TextType.dependencyFolder)}:',
            style: context.appTextStyles.largeBoldTextWithTransparentBackground,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: AdvancedDragAndDropField(
            title: ref.translateText(textType: TextType.dragAndDropDependencyFolder),
            path: homeViewState.dependencyFolderPath,
            onDragDone: (DropDoneDetails details) async => await _onDragDone(details, ref),
            onDragEntered: (DropEventDetails details) async => await _onDragEntered(details, ref),
            onDragExited: (DropEventDetails details) async => await _onDragExited(details, ref),
            isDisabled: homeViewState.isDependencyFolderPathFieldDisabled,
            isSomethingBeingDraggedCurrently: homeViewState.isDependencyFolderPathBeingDroppedCurrently,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _onDragDone(DropDoneDetails details, WidgetRef ref) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    final loadingController = ref.read(LoadingProvider.loadingControllerProvider.notifier);

    if (details.files.length > 1 || details.files.first.path.isEmpty || details.files.first.path.contains('.')) {
      return;
    }

    loadingController.isLoading = true;
    homeViewController.dependencyFolderPath = details.files.first.path;
    homeViewController.isDependencyFolderPathFieldDisabled = true;
    loadingController.isLoading = false;
  }

  Future<void> _onDragEntered(DropEventDetails details, WidgetRef ref) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    homeViewController.isDependencyFolderPathBeingDroppedCurrently = true;
  }

  Future<void> _onDragExited(DropEventDetails details, WidgetRef ref) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    homeViewController.isDependencyFolderPathBeingDroppedCurrently = false;
  }
}
