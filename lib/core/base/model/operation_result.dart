import 'package:obfuscation_controller/core/error/model/failure.dart';

class OperationResult<T> {
  final T data;
  final Failure? failure;

  const OperationResult({
    required this.data,
    required this.failure,
  });

  bool get hasData => data != null;
  bool get hasFailure => failure != null;

  /// Creates a copy of this class.
  OperationResult<T> copyWith({
    T? data,
    Failure? failure,
  }) {
    return OperationResult<T>(
      data: data ?? this.data,
      failure: failure ?? this.failure,
    );
  }
}
