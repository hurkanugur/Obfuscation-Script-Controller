// ignore_for_file: unused_local_variable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/error/model/failure.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/localization/provider/localization_provider.dart';

extension LocalizationExtension on WidgetRef {
  String translateText({required TextType textType}) {
    final localizationState = watch(LocalizationProvider.localizationControllerProvider);
    final localizationController = watch(LocalizationProvider.localizationControllerProvider.notifier);
    return localizationController.translateText(textType: textType);
  }

  String translateFailure({required Failure failure}) {
    final localizationState = watch(LocalizationProvider.localizationControllerProvider);
    final localizationController = watch(LocalizationProvider.localizationControllerProvider.notifier);
    return localizationController.translateFailure(failure: failure);
  }
}
