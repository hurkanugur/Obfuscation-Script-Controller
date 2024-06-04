import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  final StackTrace stackTrace;
  final Object? exception;
  final DateTime dateTime;

  const Failure({
    required this.exception,
    required this.stackTrace,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [stackTrace, exception];

  /// Creates a copy of this class.
  Failure copyWith({
    StackTrace? stackTrace,
    Object? exception,
    DateTime? dateTime,
  }) {
    return Failure(
      exception: exception ?? this.exception,
      stackTrace: stackTrace ?? this.stackTrace,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
