import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/permission/menu/controller/permission_menu_controller.dart';
import 'package:obfuscation_controller/core/permission/menu/provider/permission_provider.dart';
import 'package:permission_handler/permission_handler.dart';

extension PermissionExtension on WidgetRef {
  // Mutex to prevent multiple concurrent permission requests.
  static bool _requestPermissionMutex = false;

  /// Checks if the specified [permission] is granted.
  ///
  /// If [requestPermissionSilentlyOnDenied] is true, the permission will be requested if it is not already granted.
  ///
  /// If [displayPermissionRequestMenuOnPermanentlyDenied] is true, a menu will be displayed to request the permission if it is permanently denied.
  Future<PermissionStatus?> _requestPermission({
    required Permission permission,
    required TextType permissionMenuTitle,
    required TextType permissionMenuExplanationText,
    required bool requestPermissionSilentlyOnDenied,
    required bool displayPermissionRequestMenuOnPermanentlyDenied,
  }) async {
    try {
      if (_requestPermissionMutex) {
        return PermissionStatus.permanentlyDenied;
      }

      _requestPermissionMutex = true;

      final PermissionStatus currentStatus = await permission.status;
      if (isPermissionGranted(currentStatus) || !requestPermissionSilentlyOnDenied) {
        _requestPermissionMutex = false;
        return currentStatus;
      }

      final PermissionStatus newStatus = await permission.request();
      if (isPermissionGranted(newStatus) || !displayPermissionRequestMenuOnPermanentlyDenied || (isPermissionNeverAskedBefore(currentStatus) && isPermissionPermanentlyDenied(newStatus))) {
        _requestPermissionMutex = false;
        return newStatus;
      }

      final permissionController = read(PermissionProvider.permissionMenuControllerProvider.notifier);
      PermissionStatus? menuPermissionStatus;

      if (context.mounted) {
        await permissionController.showMenu(
          context: context,
          permissionMenuState: PermissionMenuState(
            title: permissionMenuTitle,
            explanation: permissionMenuExplanationText,
            onDonePressed: () async {
              menuPermissionStatus = PermissionStatus.permanentlyDenied;
              openAppSettings();
            },
          ),
        );
      }

      _requestPermissionMutex = false;
      return menuPermissionStatus;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.permissionRequiredError,
        exception: ex,
      );

      _requestPermissionMutex = false;
      return null;
    }
  }

  /// Determines if the permission is granted.
  bool isPermissionGranted(PermissionStatus? status) {
    return status == PermissionStatus.granted || status == PermissionStatus.limited;
  }

  /// Determines if the permission has never been asked before.
  bool isPermissionNeverAskedBefore(PermissionStatus? status) {
    return status == PermissionStatus.denied;
  }

  /// Determines if the permission is permanently denied.
  bool isPermissionPermanentlyDenied(PermissionStatus? status) {
    return status == PermissionStatus.permanentlyDenied;
  }

  /// Determines if the permission request was canceled.
  bool isPermissionRequestCanceled(PermissionStatus? status) {
    return status == null;
  }

  /// Requests storage access permission.
  ///
  /// If [requestPermissionSilentlyOnDenied] is true, the permission will be requested if it is not already granted.
  ///
  /// If [displayPermissionRequestMenuOnPermanentlyDenied] is true, a menu will be displayed to request the permission if it is permanently denied.
  Future<PermissionStatus?> requestStorageAccessPermission({
    required bool requestPermissionSilentlyOnDenied,
    required bool displayPermissionRequestMenuOnPermanentlyDenied,
  }) async {
    return await _requestPermission(
      permission: Permission.storage,
      permissionMenuTitle: TextType.storageAccessPermissionRequestTitle,
      permissionMenuExplanationText: TextType.storageAccessPermissionRequestExplanation,
      requestPermissionSilentlyOnDenied: requestPermissionSilentlyOnDenied,
      displayPermissionRequestMenuOnPermanentlyDenied: displayPermissionRequestMenuOnPermanentlyDenied,
    );
  }
}
