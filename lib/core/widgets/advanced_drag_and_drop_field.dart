import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';

class AdvancedDragAndDropField extends ConsumerWidget {
  const AdvancedDragAndDropField({
    super.key,
    required this.fieldName,
    required this.title,
    required this.path,
    required this.icon,
    required this.onDragDone,
    required this.onDragEntered,
    required this.onDragExited,
    required this.isDisabled,
    required this.isSomethingBeingDraggedCurrently,
  });

  final IconData icon;
  final String fieldName;
  final String title;
  final String path;
  final Future<void> Function(DropDoneDetails)? onDragDone;
  final Future<void> Function(DropEventDetails)? onDragEntered;
  final Future<void> Function(DropEventDetails)? onDragExited;
  final bool isDisabled;
  final bool isSomethingBeingDraggedCurrently;

  /// Creates a copy of this class.
  AdvancedDragAndDropField copyWith({
    String? fieldName,
    String? title,
    String? path,
    IconData? icon,
    Future<void> Function(DropDoneDetails)? onDragDone,
    Future<void> Function(DropEventDetails)? onDragEntered,
    Future<void> Function(DropEventDetails)? onDragExited,
    bool? isDisabled,
    bool? isSomethingBeingDraggedCurrently,
  }) {
    return AdvancedDragAndDropField(
      fieldName: fieldName ?? this.fieldName,
      title: title ?? this.title,
      path: path ?? this.path,
      icon: icon ?? this.icon,
      onDragDone: onDragDone ?? this.onDragDone,
      onDragEntered: onDragEntered ?? this.onDragEntered,
      onDragExited: onDragExited ?? this.onDragExited,
      isDisabled: isDisabled ?? this.isDisabled,
      isSomethingBeingDraggedCurrently: isSomethingBeingDraggedCurrently ?? this.isSomethingBeingDraggedCurrently,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropTarget(
      onDragDone: onDragDone,
      onDragEntered: onDragEntered,
      onDragExited: onDragExited,
      enable: !isDisabled,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: isSomethingBeingDraggedCurrently ? context.appColors.filledWidgetSelectedBackgroundColor : context.appColors.transparentWidgetUnselectedBackgroundColor,
          border: Border.all(color: context.appColors.transparentWidgetBorderColor!),
          borderRadius: BorderRadius.circular(AppDimensions.widgetRadius),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (path.isEmpty) ...[
                Icon(
                  icon,
                  color: isSomethingBeingDraggedCurrently ? context.appColors.filledWidgetForegroundColor : context.appColors.transparentWidgetForegroundColor,
                  size: AppDimensions.dragAndDropIconSize,
                ),
              ],
              const SizedBox(height: 10),
              Text(
                fieldName,
                textAlign: TextAlign.center,
                style: isSomethingBeingDraggedCurrently ? context.appTextStyles.largeBoldTextWithFilledBackground : context.appTextStyles.largeBoldTextWithTransparentBackground,
              ),
              const SizedBox(height: 10),
              Text(
                path.isEmpty ? title : path,
                textAlign: TextAlign.center,
                style: isSomethingBeingDraggedCurrently ? context.appTextStyles.mediumTextWithFilledBackground : context.appTextStyles.mediumTextWithTransparentBackground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
