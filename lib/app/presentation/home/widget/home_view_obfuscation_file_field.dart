import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/home/provider/home_view_provider.dart';
import 'package:obfuscation_controller/core/loading/provider/loading_provider.dart';
import 'package:obfuscation_controller/config/app_icons.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_drag_and_drop_field.dart';

class HomeViewObfuscationFileField extends ConsumerWidget {
  const HomeViewObfuscationFileField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewState = ref.watch(HomeViewProvider.homeViewProvider);

    return MouseRegion(
      cursor: homeViewState.obfuscationFilePath.isNotEmpty ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: homeViewState.obfuscationFilePath.isNotEmpty ? null : () async => await _onClicked(ref: ref),
        child: AdvancedDragAndDropField(
          fieldName: ref.translateText(textType: TextType.obfuscationFile),
          title: ref.translateText(textType: TextType.dragAndDropObfuscationFile),
          path: homeViewState.obfuscationFilePath,
          icon: AppIcons.addFileIcon,
          onDragDone: (DropDoneDetails details) async => await _onDragDone(details, ref),
          onDragEntered: (DropEventDetails details) async => await _onDragEntered(details, ref),
          onDragExited: (DropEventDetails details) async => await _onDragExited(details, ref),
          isDisabled: homeViewState.isObfuscationFilePathFieldDisabled,
          isSomethingBeingDraggedCurrently: homeViewState.isObfuscationFilePathBeingDroppedCurrently,
        ),
      ),
    );
  }

  Future<void> _onClicked({required WidgetRef ref}) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    final loadingController = ref.read(LoadingProvider.loadingControllerProvider.notifier);

    loadingController.isLoading = true;
    await homeViewController.pickObfuscationFile(ref: ref);
    loadingController.isLoading = false;
  }

  Future<void> _onDragDone(DropDoneDetails details, WidgetRef ref) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    final loadingController = ref.read(LoadingProvider.loadingControllerProvider.notifier);

    if (details.files.length > 1 || !details.files.first.path.endsWith('txt')) {
      return;
    }

    loadingController.isLoading = true;
    homeViewController.obfuscationFilePath = details.files.first.path;
    homeViewController.isObfuscationFilePathFieldDisabled = true;
    loadingController.isLoading = false;
  }

  Future<void> _onDragEntered(DropEventDetails details, WidgetRef ref) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    homeViewController.isObfuscationFilePathBeingDroppedCurrently = true;
  }

  Future<void> _onDragExited(DropEventDetails details, WidgetRef ref) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    homeViewController.isObfuscationFilePathBeingDroppedCurrently = false;
  }
}
