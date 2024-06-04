import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/log/menu/view/log_details_menu_view.dart';

class LogDetailsMenuState {
  final String? className;
  final String? methodName;
  final DateTime? dateTime;
  final int? statusCode;
  final String? localizedMessage;
  final String? exceptionMessage;
  final StackTrace? stackTrace;

  const LogDetailsMenuState({
    required this.className,
    required this.methodName,
    required this.dateTime,
    required this.statusCode,
    required this.localizedMessage,
    required this.exceptionMessage,
    required this.stackTrace,
  });

  /// Creates a copy of this class.
  LogDetailsMenuState copyWith({
    String? className,
    String? methodName,
    DateTime? dateTime,
    int? statusCode,
    String? localizedMessage,
    String? exceptionMessage,
    StackTrace? stackTrace,
  }) {
    return LogDetailsMenuState(
      className: className ?? this.className,
      methodName: methodName ?? this.methodName,
      dateTime: dateTime ?? this.dateTime,
      statusCode: statusCode ?? this.statusCode,
      localizedMessage: localizedMessage ?? this.localizedMessage,
      exceptionMessage: exceptionMessage ?? this.exceptionMessage,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

class LogDetailsMenuController extends StateNotifier<LogDetailsMenuState> {
  LogDetailsMenuController()
      : super(
          const LogDetailsMenuState(
            className: null,
            methodName: null,
            dateTime: null,
            statusCode: null,
            localizedMessage: null,
            exceptionMessage: null,
            stackTrace: null,
          ),
        );

  Future<void> showMenu({required BuildContext context, required LogDetailsMenuState logDetailsMenuState}) async {
    state = logDetailsMenuState;

    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => const LogDetailsMenuView(),
    );

    resetState();
  }

  void resetState() {
    state = const LogDetailsMenuState(
      className: null,
      methodName: null,
      dateTime: null,
      statusCode: null,
      localizedMessage: null,
      exceptionMessage: null,
      stackTrace: null,
    );
  }
}
