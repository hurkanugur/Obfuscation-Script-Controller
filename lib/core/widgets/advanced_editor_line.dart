import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/app/domain/editor/enum/line_type.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_editor_line_model.dart';

class AdvancedEditorLine extends ConsumerWidget {
  final AdvancedEditorLineModel advancedEditorLineModel;

  const AdvancedEditorLine({
    super.key,
    required this.advancedEditorLineModel,
  });

  /// Creates a copy of this class.
  AdvancedEditorLine copyWith({
    AdvancedEditorLineModel? advancedEditorLineModel,
  }) {
    return AdvancedEditorLine(
      advancedEditorLineModel: advancedEditorLineModel ?? this.advancedEditorLineModel,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimensions.lineHeight,
      child: Row(
        children: <Widget>[
          Text(
            advancedEditorLineModel.lineNumber.toString(),
            style: context.appTextStyles.smallBoldTextWithTransparentBackground,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              advancedEditorLineModel.line.trim(),
              style: _getTextStyle(context: context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle? _getTextStyle({required BuildContext context}) {
    return switch (advancedEditorLineModel.lineType) {
      LineType.normal => advancedEditorLineModel.isBeingFocused ? context.appTextStyles.smallWarningBoldText : context.appTextStyles.smallTextWithTransparentBackground,
      LineType.success => advancedEditorLineModel.isBeingFocused ? context.appTextStyles.smallWarningBoldText : context.appTextStyles.smallInfoText,
      LineType.warning => advancedEditorLineModel.isBeingFocused ? context.appTextStyles.smallWarningBoldText : context.appTextStyles.smallErrorText,
    };
  }
}
