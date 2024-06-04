import 'package:dio/dio.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';

enum DioProblemType {
  connectionTimeout('CONNECTION_TIMEOUT'),
  sendTimeout('SEND_TIMEOUT'),
  receiveTimeout('RECEIVE_TIMEOUT'),
  badCertificate('BAD_CERTIFICATE'),
  badResponse('BAD_RESPONSE'),
  cancel('CANCEL'),
  connectionError('CONNECTION'),
  unknown('UNKNOWN');

  final String name;

  const DioProblemType(this.name);

  /// Creates a [DioProblemType] from [dioExceptionType].
  ///
  /// Returns `null` when the enum is not found.
  DioProblemType? findByDioException({required DioExceptionType dioExceptionType}) {
    try {
      return values.firstWhere((element) => element.name == dioExceptionType.name);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
    return null;
  }
}

enum UnknownProblemType {
  nullResponseValueError('NULL_RESPONSE_VALUE_ERROR'),
  unknownException('UNKNOWN_EXCEPTION');

  final String name;

  const UnknownProblemType(this.name);

  /// Creates a [UnknownProblemType] from [serverProblemName].
  ///
  /// Returns `null` when the enum is not found.
  static UnknownProblemType? findByName({required String? serverProblemName}) {
    try {
      return values.firstWhere((element) => element.name == serverProblemName);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
    return null;
  }
}
