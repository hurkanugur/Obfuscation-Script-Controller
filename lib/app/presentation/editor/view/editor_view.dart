import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/editor/provider/editor_view.provider.dart';
import 'package:obfuscation_controller/app/presentation/editor/widget/editor_view_dependency_folder_contents.dart';
import 'package:obfuscation_controller/app/presentation/editor/widget/editor_view_obfuscation_file_contents.dart';
import 'package:obfuscation_controller/app/presentation/editor/widget/editor_view_top_section.dart';
import 'package:obfuscation_controller/app/presentation/home/provider/home_view_provider.dart';
import 'package:obfuscation_controller/app/presentation/loading/provider/loading_provider.dart';
import 'package:obfuscation_controller/core/animation/constants/animation_constants.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_pop_scope.dart';

class EditorView extends ConsumerStatefulWidget {
  const EditorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditorViewState();
}

class _EditorViewState extends ConsumerState<EditorView> {
  @override
  void initState() {
    super.initState();

    final homeViewController = ref.read(HomeViewProvider.homeViewProvider.notifier);
    final editorViewController = ref.read(EditorViewProvider.editorViewProvider.notifier);
    final loadingController = ref.read(LoadingProvider.loadingControllerProvider.notifier);

    Future.delayed(const Duration(milliseconds: AnimationConstants.pageViewAnimationDurationMS)).then((_) async {
      loadingController.isLoading = true;
      await Future.delayed(const Duration(milliseconds: 500));
      await editorViewController.fetchData(
        obfuscationFilePath: homeViewController.obfuscationFilePath,
        dependencyFolderPath: homeViewController.dependencyFolderPath,
      );
      await Future.delayed(const Duration(milliseconds: 200));

      editorViewController.obfuscationFileScrollToEnd();
      editorViewController.dependencyFolderScrollToEnd();
      loadingController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedPopScope(
      onPopScope: () => _onDeviceBackButtonPressed(ref),
      child: Scaffold(
        backgroundColor: context.appColors.scaffoldBackgroundColor,
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            EditorViewTopSection(),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: EditorViewObfuscationFileContents()),
                  SizedBox(width: 20),
                  Expanded(child: EditorViewDependencyFolderContents()),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _onDeviceBackButtonPressed(WidgetRef ref) async {}
}
