import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/loading/provider/loading_provider.dart';
import 'package:obfuscation_controller/core/log/menu/provider/log_provider.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_class_name_textfield.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_close_button.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_datetime_message_textfield.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_exception_message_textfield.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_localized_message_textfield.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_lottie_animation.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_menu_title.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_method_name_textfield.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_stack_trace_textfield.dart';
import 'package:obfuscation_controller/core/log/menu/widget/log_details_menu_status_code_textfield.dart';
import 'package:obfuscation_controller/core/router/extension/router_extension.dart';
import 'package:obfuscation_controller/core/widgets/advanced_dialog_template.dart';

class LogDetailsMenuView extends ConsumerWidget {
  const LogDetailsMenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdvancedDialogTemplate(
      onPopScope: () async => await _onDeviceBackButtonPressed(ref: ref),
      widgets: const [
        SizedBox(height: 20),
        LogDetailsMenuTitle(),
        SizedBox(height: 20),
        LogDetailsMenuLottieAnimation(),
        SizedBox(height: 20),
        LogDetailsMenuClassNameTextField(),
        SizedBox(height: 20),
        LogDetailsMenuMethodNameTextField(),
        SizedBox(height: 20),
        LogDetailsMenuDateTimeTextField(),
        SizedBox(height: 20),
        LogDetailsMenuStatusCodeTextField(),
        SizedBox(height: 20),
        LogDetailsMenuLocalizedMessageTextField(),
        SizedBox(height: 20),
        LogDetailsMenuExceptionMessageTextField(),
        SizedBox(height: 20),
        LogDetailsMenuStackTraceTextField(),
        SizedBox(height: 20),
        LoginDetailsMenuCloseButton(),
        SizedBox(height: 20),
      ],
    );
  }

  Future<void> _onDeviceBackButtonPressed({required WidgetRef ref}) async {
    final loadingController = ref.read(LoadingProvider.loadingControllerProvider.notifier);
    final logDetailsMenuController = ref.read(LogProvider.logDetailsMenuControllerProvider.notifier);

    if (!loadingController.isLoading) {
      logDetailsMenuController.resetState();
      ref.context.goBack();
    }
  }
}
