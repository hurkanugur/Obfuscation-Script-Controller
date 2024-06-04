import 'package:equatable/equatable.dart';
import 'package:obfuscation_controller/app/domain/file/enum/line_type.dart';

class AdvancedLineModel extends Equatable {
  final String filePath;
  final int lineNumber;
  final String line;
  final LineType lineType;

  const AdvancedLineModel({
    required this.filePath,
    required this.lineNumber,
    required this.line,
    required this.lineType,
  });

  /// Creates a copy of this class.
  AdvancedLineModel copyWith({
    String? filePath,
    int? lineNumber,
    String? line,
    LineType? lineType,
  }) {
    return AdvancedLineModel(
      filePath: filePath ?? this.filePath,
      lineNumber: lineNumber ?? this.lineNumber,
      line: line ?? this.line,
      lineType: lineType ?? this.lineType,
    );
  }

  @override
  List<Object?> get props => [filePath, lineNumber, line, lineType];
}
