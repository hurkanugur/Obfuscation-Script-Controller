import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/editor/enum/line_type.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_line_model.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_editor_line.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AdvancedEditorField extends ConsumerWidget {
  final String title;
  final IconData titleIcon;
  final List<AdvancedLineModel> smartLines;
  final ItemScrollController itemScrollController;

  const AdvancedEditorField({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.smartLines,
    required this.itemScrollController,
  });

  /// Creates a copy of this class.
  AdvancedEditorField copyWith({
    String? title,
    IconData? titleIcon,
    List<AdvancedLineModel>? smartLines,
    ItemScrollController? itemScrollController,
  }) {
    return AdvancedEditorField(
      title: title ?? this.title,
      titleIcon: titleIcon ?? this.titleIcon,
      smartLines: smartLines ?? this.smartLines,
      itemScrollController: itemScrollController ?? this.itemScrollController,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.widgetRadius),
        border: Border.all(color: context.appColors.transparentWidgetBorderColor!),
      ),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          _createTitle(ref: ref),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ScrollablePositionedList.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemScrollController: itemScrollController,
                scrollDirection: Axis.vertical,
                itemCount: smartLines.length,
                itemBuilder: (context, index) {
                  if (smartLines.isNotEmpty && index >= 0) {
                    return AdvancedEditorLine(advancedEditorLineModel: smartLines.elementAt(index));
                  } else {
                    return const AdvancedEditorLine(
                      advancedEditorLineModel: AdvancedLineModel(
                        filePath: '',
                        lineNumber: 0,
                        line: '',
                        lineType: LineType.warning,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTitle({required WidgetRef ref}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.sizeOf(ref.context).width,
      height: AppDimensions.widgetHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.widgetRadius),
          topRight: Radius.circular(AppDimensions.widgetRadius),
        ),
        border: Border.all(color: ref.context.appColors.transparentWidgetBorderColor!),
      ),
      child: Row(
        children: [
          Icon(
            titleIcon,
            color: ref.context.appColors.transparentWidgetForegroundColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: ref.context.appTextStyles.smallBoldTextWithTransparentBackground,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
