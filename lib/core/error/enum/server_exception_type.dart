import 'package:dio/dio.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/enum/server_problem_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';

enum ServerExceptionType {
  dioException('DIO_EXCEPTION', DioProblemType.values),
  unknownException('UNKNOWN_EXCEPTION', UnknownProblemType.values);

  final String name;

  final List<Enum> problemTypes;

  const ServerExceptionType(this.name, this.problemTypes);

  /// Creates a [ServerExceptionType] from [serverExceptionName].
  ///
  /// Returns `null` when the enum is not found.
  static ServerExceptionType? getServerExceptionByName({required String? serverExceptionName}) {
    try {
      return values.firstWhere((element) => element.name == serverExceptionName);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
    return null;
  }

  /// Retrieves a problem type by its name.
  ///
  /// Returns `null` when the enum is not found.
  Enum? getProblemByName({required String? serverProblemName}) {
    try {
      return switch (this) {
        ServerExceptionType.unknownException => UnknownProblemType.findByName(serverProblemName: serverProblemName),
        ServerExceptionType.dioException => DioExceptionType.values.firstWhere((element) => element.name == serverProblemName, orElse: () => DioExceptionType.unknown),
      };
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
