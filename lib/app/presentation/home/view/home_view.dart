import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/presentation/home/widget/home_view_top_section.dart';
import 'package:obfuscation_controller/app/presentation/home/widget/home_view_bottom_section.dart';
import 'package:obfuscation_controller/app/presentation/home/widget/home_view_obfuscation_file_field.dart';
import 'package:obfuscation_controller/app/presentation/home/widget/home_view_dependency_folder_field.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_pop_scope.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return AdvancedPopScope(
      onPopScope: () async => await _onDeviceBackButtonPressed(ref: ref),
      child: Scaffold(
        backgroundColor: context.appColors.scaffoldBackgroundColor,
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            HomeViewTopSection(),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: HomeViewObfuscationFileField()),
                  SizedBox(width: 20),
                  Expanded(child: HomeViewDependencyFolderField()),
                ],
              ),
            ),
            SizedBox(height: 20),
            HomeViewBottomSection(),
          ]),
        ),
      ),
    );
  }

  Future<void> _onDeviceBackButtonPressed({required WidgetRef ref}) async {}
}
