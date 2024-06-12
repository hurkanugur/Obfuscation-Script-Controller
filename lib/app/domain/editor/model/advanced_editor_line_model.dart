import 'package:equatable/equatable.dart';
import 'package:obfuscation_controller/app/domain/editor/enum/line_type.dart';

class AdvancedEditorLineModel extends Equatable {
  final String filePath;
  final int lineNumber;
  final String line;
  final LineType lineType;
  final bool isBeingFocused;

  const AdvancedEditorLineModel({
    required this.filePath,
    required this.lineNumber,
    required this.line,
    required this.lineType,
    this.isBeingFocused = false,
  });

  /// Creates a copy of this class.
  AdvancedEditorLineModel copyWith({
    String? filePath,
    int? lineNumber,
    String? line,
    LineType? lineType,
    bool? isBeingFocused,
  }) {
    return AdvancedEditorLineModel(
      filePath: filePath ?? this.filePath,
      lineNumber: lineNumber ?? this.lineNumber,
      line: line ?? this.line,
      lineType: lineType ?? this.lineType,
      isBeingFocused: isBeingFocused ?? this.isBeingFocused,
    );
  }

  @override
  List<Object?> get props => [filePath, lineNumber, line, lineType, isBeingFocused];
}
