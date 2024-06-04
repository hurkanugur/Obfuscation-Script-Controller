import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/config/app_dimensions.dart';
import 'package:obfuscation_controller/config/app_icons.dart';
import 'package:obfuscation_controller/core/error/model/failure.dart';
import 'package:obfuscation_controller/core/error/model/server_failure.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/extension/localization_extension.dart';
import 'package:obfuscation_controller/core/log/extension/log_extension.dart';
import 'package:obfuscation_controller/core/log/menu/controller/log_details_menu_controller.dart';
import 'package:obfuscation_controller/core/log/menu/provider/log_provider.dart';
import 'package:obfuscation_controller/core/theme/extension/theme_extension.dart';

extension SnackbarExtension on WidgetRef {
  void showFailureSnackbar({required Failure failure}) {
    final logDetailsMenuController = read(LogProvider.logDetailsMenuControllerProvider.notifier);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              AppIcons.errorIcon,
              size: AppDimensions.snackbarHeaderIconSize,
              color: context.appColors.filledWidgetForegroundColor,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                translateFailure(failure: failure),
                style: context.appTextStyles.mediumTextWithFilledBackground,
              ),
            ),
          ],
        ),
        backgroundColor: context.appColors.errorColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        margin: const EdgeInsets.all(16.0),
        action: SnackBarAction(
          label: translateText(textType: TextType.details),
          textColor: context.appColors.filledWidgetForegroundColor,
          backgroundColor: context.appColors.errorColor,
          onPressed: () => logDetailsMenuController.showMenu(
            context: context,
            logDetailsMenuState: LogDetailsMenuState(
              className: failure.stackTrace.findClassName(),
              methodName: failure.stackTrace.findMethodName(),
              dateTime: failure.dateTime,
              statusCode: failure is ServerFailure ? failure.statusCode : null,
              localizedMessage: translateFailure(failure: failure),
              exceptionMessage: failure.exception.toString(),
              stackTrace: failure.stackTrace,
            ),
          ),
        ),
      ),
    );
  }
}
