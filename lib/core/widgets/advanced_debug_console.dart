import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_line_model.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_console_error_text.dart';

class AdvancedDebugConsole extends ConsumerWidget {
  final ScrollController scrollController;
  final List<AdvancedLineModel> sortedErrorList;
  final String Function(WidgetRef, AdvancedLineModel) errorMessageCreator;
  final Future<void> Function(WidgetRef, AdvancedLineModel) onItemTap;

  const AdvancedDebugConsole({
    super.key,
    required this.scrollController,
    required this.sortedErrorList,
    required this.errorMessageCreator,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.widgetRadius),
        border: Border.all(color: context.appColors.transparentWidgetBorderColor!),
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerSection(ref: ref),
          const SizedBox(height: 12),
          Expanded(child: _createListOrNoErrorsText(ref: ref)),
        ],
      ),
    );
  }

  Widget _headerSection({required WidgetRef ref}) {
    return SizedBox(
      width: MediaQuery.sizeOf(ref.context).width,
      child: Row(
        children: [
          Text(
            ref.translateText(textType: TextType.errors),
            style: ref.context.appTextStyles.mediumBoldTextWithTransparentBackground,
            overflow: TextOverflow.ellipsis,
          ),
          if (sortedErrorList.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ref.context.appColors.errorColor,
                borderRadius: BorderRadius.circular(AppDimensions.widgetRadius),
              ),
              child: Text(
                sortedErrorList.length.toString(),
                textAlign: TextAlign.start,
                style: ref.context.appTextStyles.mediumBoldTextWithFilledBackground,
              ),
            )
          ],
        ],
      ),
    );
  }

  Widget _createListOrNoErrorsText({required WidgetRef ref}) {
    if (sortedErrorList.isEmpty) {
      return Text(
        ref.translateText(textType: TextType.noErrorsFound),
        style: ref.context.appTextStyles.smallInfoBoldText,
        overflow: TextOverflow.ellipsis,
      );
    }

    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        controller: scrollController,
        scrollDirection: Axis.vertical,
        itemCount: sortedErrorList.length,
        itemBuilder: (context, index) {
          final AdvancedLineModel advancedLineModel = sortedErrorList.elementAt(index);
          return AdvancedConsoleErrorText(
            advancedLineModel: advancedLineModel,
            errorMessage: errorMessageCreator(ref, advancedLineModel),
            onTap: () async => await onItemTap(ref, advancedLineModel),
          );
        },
      ),
    );
  }
}
