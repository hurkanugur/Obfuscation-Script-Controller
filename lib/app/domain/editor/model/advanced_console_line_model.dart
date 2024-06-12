import 'package:equatable/equatable.dart';
import 'package:obfuscation_controller/app/domain/editor/enum/line_type.dart';
import 'package:obfuscation_controller/core/localization/enum/text_type.dart';

class AdvancedConsoleLineModel extends Equatable {
  final String? obfuscationFileLine;
  final String? dependencyFolderLine;
  final int? obfuscationLineNumber;
  final int? dependencyLineNumber;
  final TextType errorTextType;
  final LineType lineType;

  const AdvancedConsoleLineModel({
    required this.obfuscationFileLine,
    required this.dependencyFolderLine,
    required this.obfuscationLineNumber,
    required this.dependencyLineNumber,
    required this.errorTextType,
    required this.lineType,
  });

  /// Creates a copy of this class.
  AdvancedConsoleLineModel copyWith({
    String? obfuscationFileLine,
    String? dependencyFolderLine,
    int? obfuscationLineNumber,
    int? dependencyLineNumber,
    TextType? errorTextType,
    LineType? lineType,
  }) {
    return AdvancedConsoleLineModel(
      obfuscationFileLine: obfuscationFileLine ?? this.obfuscationFileLine,
      dependencyFolderLine: dependencyFolderLine ?? this.dependencyFolderLine,
      obfuscationLineNumber: obfuscationLineNumber ?? this.obfuscationLineNumber,
      dependencyLineNumber: dependencyLineNumber ?? this.dependencyLineNumber,
      errorTextType: errorTextType ?? this.errorTextType,
      lineType: lineType ?? this.lineType,
    );
  }

  @override
  List<Object?> get props => [obfuscationFileLine, dependencyFolderLine, obfuscationLineNumber, dependencyLineNumber, errorTextType, lineType];
}
