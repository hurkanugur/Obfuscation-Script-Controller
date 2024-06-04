// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_pop_scope.dart';

class AdvancedDialogTemplate extends StatelessWidget {
  const AdvancedDialogTemplate({
    required this.widgets,
    required this.onPopScope,
  });

  final Future<void> Function() onPopScope;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.orientationOf(context);
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    final double widthRatio = (orientation == Orientation.portrait ? 5 : 3);
    final double heightRatio = (orientation == Orientation.portrait ? 3 : 5);

    return SafeArea(
      child: AdvancedPopScope(
        onPopScope: onPopScope,
        child: Scaffold(
          backgroundColor: context.appColors.menuBarrierBackgroundColor,
          resizeToAvoidBottomInset: true,
          body: Material(
            color: context.appColors.menuBarrierBackgroundColor,
            child: Align(
              child: Container(
                color: context.appColors.transparentWidgetBackgroundColor,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: width * (widthRatio / 100.0),
                  vertical: height * (heightRatio / 100.0),
                ),
                constraints: BoxConstraints(
                  maxHeight: height,
                  maxWidth: width,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.appColors.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(AppDimensions.widgetRadius),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widgets,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
