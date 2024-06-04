import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewState {
  final String obfuscationFilePath;
  final bool isObfuscationFilePathFieldDisabled;
  final bool isObfuscationFilePathBeingDroppedCurrently;
  final String dependencyFolderPath;
  final bool isDependencyFolderPathFieldDisabled;
  final bool isDependencyFolderPathBeingDroppedCurrently;

  const HomeViewState({
    required this.obfuscationFilePath,
    required this.isObfuscationFilePathFieldDisabled,
    required this.isObfuscationFilePathBeingDroppedCurrently,
    required this.dependencyFolderPath,
    required this.isDependencyFolderPathFieldDisabled,
    required this.isDependencyFolderPathBeingDroppedCurrently,
  });

  HomeViewState copyWith({
    String? obfuscationFilePath,
    bool? isObfuscationFilePathFieldDisabled,
    bool? isObfuscationFilePathBeingDroppedCurrently,
    String? dependencyFolderPath,
    bool? isDependencyFolderPathFieldDisabled,
    bool? isDependencyFolderPathBeingDroppedCurrently,
    GlobalKey<ScaffoldState>? homeViewScaffoldKey,
  }) {
    return HomeViewState(
      obfuscationFilePath: obfuscationFilePath ?? this.obfuscationFilePath,
      isObfuscationFilePathFieldDisabled: isObfuscationFilePathFieldDisabled ?? this.isObfuscationFilePathFieldDisabled,
      isObfuscationFilePathBeingDroppedCurrently: isObfuscationFilePathBeingDroppedCurrently ?? this.isObfuscationFilePathBeingDroppedCurrently,
      dependencyFolderPath: dependencyFolderPath ?? this.dependencyFolderPath,
      isDependencyFolderPathFieldDisabled: isDependencyFolderPathFieldDisabled ?? this.isDependencyFolderPathFieldDisabled,
      isDependencyFolderPathBeingDroppedCurrently: isDependencyFolderPathBeingDroppedCurrently ?? this.isDependencyFolderPathBeingDroppedCurrently,
    );
  }
}

class HomeViewController extends StateNotifier<HomeViewState> {
  HomeViewController()
      : super(
          const HomeViewState(
            obfuscationFilePath: '',
            isObfuscationFilePathFieldDisabled: false,
            isObfuscationFilePathBeingDroppedCurrently: false,
            dependencyFolderPath: '',
            isDependencyFolderPathFieldDisabled: false,
            isDependencyFolderPathBeingDroppedCurrently: false,
          ),
        );

  /// Getter for [obfuscationFilePath].
  String get obfuscationFilePath => state.obfuscationFilePath;

  /// Setter for [obfuscationFilePath].
  set obfuscationFilePath(String? obfuscationFilePath) => state = state.copyWith(obfuscationFilePath: obfuscationFilePath ?? '');

  /// Getter for [isObfuscationFilePathFieldDisabled].
  bool get isObfuscationFilePathFieldDisabled => state.isObfuscationFilePathFieldDisabled;

  /// Setter for [isObfuscationFilePathFieldDisabled].
  set isObfuscationFilePathFieldDisabled(bool isObfuscationFilePathFieldDisabled) => state = state.copyWith(isObfuscationFilePathFieldDisabled: isObfuscationFilePathFieldDisabled);

  /// Getter for [isObfuscationFilePathBeingDroppedCurrently].
  bool get isObfuscationFilePathBeingDroppedCurrently => state.isObfuscationFilePathBeingDroppedCurrently;

  /// Setter for [isObfuscationFilePathBeingDroppedCurrently].
  set isObfuscationFilePathBeingDroppedCurrently(bool isObfuscationFilePathBeingDroppedCurrently) => state = state.copyWith(isObfuscationFilePathBeingDroppedCurrently: isObfuscationFilePathBeingDroppedCurrently);

  /// Getter for [dependencyFolderPath].
  String get dependencyFolderPath => state.dependencyFolderPath;

  /// Setter for [dependencyFolderPath].
  set dependencyFolderPath(String? dependencyFolderPath) => state = state.copyWith(dependencyFolderPath: dependencyFolderPath ?? '');

  /// Getter for [isDependencyFolderPathFieldDisabled].
  bool get isDependencyFolderPathFieldDisabled => state.isDependencyFolderPathFieldDisabled;

  /// Setter for [isDependencyFolderPathFieldDisabled].
  set isDependencyFolderPathFieldDisabled(bool isDependencyFolderPathFieldDisabled) => state = state.copyWith(isDependencyFolderPathFieldDisabled: isDependencyFolderPathFieldDisabled);

  /// Getter for [isDependencyFolderPathBeingDroppedCurrently].
  bool get isDependencyFolderPathBeingDroppedCurrently => state.isDependencyFolderPathBeingDroppedCurrently;

  /// Setter for [isDependencyFolderPathBeingDroppedCurrently].
  set isDependencyFolderPathBeingDroppedCurrently(bool isDependencyFolderPathBeingDroppedCurrently) => state = state.copyWith(isDependencyFolderPathBeingDroppedCurrently: isDependencyFolderPathBeingDroppedCurrently);

  void resetState() {
    state = const HomeViewState(
      obfuscationFilePath: '',
      isObfuscationFilePathFieldDisabled: false,
      isObfuscationFilePathBeingDroppedCurrently: false,
      dependencyFolderPath: '',
      isDependencyFolderPathFieldDisabled: false,
      isDependencyFolderPathBeingDroppedCurrently: false,
    );
  }
}
