import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/app/domain/editor/model/advanced_console_line_model.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/config/app_icons.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';

class AdvancedConsoleErrorText extends ConsumerWidget {
  final AdvancedConsoleLineModel advancedConsoleLineModel;
  final String errorMessage;
  final Future<void> Function() onTap;

  const AdvancedConsoleErrorText({
    super.key,
    required this.advancedConsoleLineModel,
    required this.errorMessage,
    required this.onTap,
  });

  /// Creates a copy of this class.
  AdvancedConsoleErrorText copyWith({
    AdvancedConsoleLineModel? advancedConsoleLineModel,
    String? errorMessage,
    Future<void> Function()? onTap,
  }) {
    return AdvancedConsoleErrorText(
      advancedConsoleLineModel: advancedConsoleLineModel ?? this.advancedConsoleLineModel,
      errorMessage: errorMessage ?? this.errorMessage,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: context.appColors.scaffoldBackgroundColor,
      child: InkWell(
        splashColor: context.appColors.scaffoldBackgroundColor,
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.widgetRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      AppIcons.errorIcon,
                      color: context.appColors.errorColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _getPathName(ref: ref),
                        style: context.appTextStyles.smallErrorBoldText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                errorMessage,
                style: context.appTextStyles.smallBoldTextWithTransparentBackground,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPathName({required WidgetRef ref}) {
    String path = '';
    if (advancedConsoleLineModel.obfuscationFileLine != null && advancedConsoleLineModel.obfuscationLineNumber != null) {
      path += '${ref.translateText(textType: TextType.obfuscationFile)} → ${ref.translateText(textType: TextType.line)} (${advancedConsoleLineModel.obfuscationLineNumber}) → ${advancedConsoleLineModel.obfuscationFileLine}\n';
    }
    if (advancedConsoleLineModel.dependencyFolderLine != null && advancedConsoleLineModel.dependencyLineNumber != null) {
      path += '${ref.translateText(textType: TextType.dependencyFolder)} → ${ref.translateText(textType: TextType.line)} (${advancedConsoleLineModel.dependencyLineNumber}) → ${advancedConsoleLineModel.dependencyFolderLine}\n';
    }
    return path.trim();
  }
}
