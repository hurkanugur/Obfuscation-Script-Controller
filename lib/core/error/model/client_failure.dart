import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/failure.dart';
import 'package:obfuscation_controller/core/log/extension/log_extension.dart';

class ClientFailure extends Failure {
  final ClientExceptionType clientExceptionType;

  const ClientFailure({
    required super.stackTrace,
    required super.dateTime,
    super.exception,
    required this.clientExceptionType,
  });

  @override
  List<Object?> get props => [stackTrace, dateTime, exception, clientExceptionType];

  @override
  ClientFailure copyWith({
    StackTrace? stackTrace,
    DateTime? dateTime,
    Object? exception,
    ClientExceptionType? clientExceptionType,
  }) {
    return ClientFailure(
      stackTrace: stackTrace ?? this.stackTrace,
      dateTime: dateTime ?? this.dateTime,
      exception: exception ?? this.exception,
      clientExceptionType: clientExceptionType ?? this.clientExceptionType,
    );
  }

  /// Creates a [ClientFailure] and logs the failure.
  factory ClientFailure.createAndLog({
    required StackTrace stackTrace,
    required ClientExceptionType clientExceptionType,
    Object? exception,
  }) {
    final ClientFailure clientFailure = ClientFailure(
      stackTrace: stackTrace,
      dateTime: DateTime.now(),
      exception: exception,
      clientExceptionType: clientExceptionType,
    );

    stackTrace.printErrorMessageByFailure(failure: clientFailure);
    return clientFailure;
  }
}
