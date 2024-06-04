import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';
import 'package:obfuscation_controller/core/permission/menu/view/permission_menu_view.dart';

class PermissionMenuState {
  final TextType? title;
  final TextType? explanation;
  final Future<void>? Function()? onDonePressed;

  const PermissionMenuState({
    required this.title,
    required this.explanation,
    required this.onDonePressed,
  });

  /// Creates a copy of this class.
  PermissionMenuState copyWith({
    TextType? title,
    TextType? explanation,
    Future<void>? Function()? onDonePressed,
  }) {
    return PermissionMenuState(
      title: title ?? this.title,
      explanation: explanation ?? this.explanation,
      onDonePressed: onDonePressed ?? this.onDonePressed,
    );
  }
}

class PermissionMenuController extends StateNotifier<PermissionMenuState> {
  PermissionMenuController()
      : super(
          const PermissionMenuState(
            title: null,
            explanation: null,
            onDonePressed: null,
          ),
        );

  Future<void> showMenu({required BuildContext context, required PermissionMenuState permissionMenuState}) async {
    state = permissionMenuState;

    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => const PermissionMenuView(),
    );

    resetState();
  }

  Future<void>? Function()? get onDonePressed => state.onDonePressed;

  void resetState() {
    state = const PermissionMenuState(
      title: null,
      explanation: null,
      onDonePressed: null,
    );
  }
}
