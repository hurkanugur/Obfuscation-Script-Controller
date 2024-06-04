import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/file/enum/line_type.dart';
import 'package:obfuscation_controller/app/domain/file/model/advanced_line_model.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_editor_line.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AdvancedEditorField extends ConsumerWidget {
  final List<AdvancedLineModel> smartLines;
  final ItemScrollController itemScrollController;

  const AdvancedEditorField({
    super.key,
    required this.smartLines,
    required this.itemScrollController,
  });

  /// Creates a copy of this class.
  AdvancedEditorField copyWith({
    List<AdvancedLineModel>? smartLines,
    ItemScrollController? itemScrollController,
  }) {
    return AdvancedEditorField(
      smartLines: smartLines ?? this.smartLines,
      itemScrollController: itemScrollController ?? this.itemScrollController,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.widgetRadius),
        border: Border.all(color: context.appColors.transparentWidgetBorderColor!),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
    );
  }
}
