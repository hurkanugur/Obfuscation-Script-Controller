import 'package:equatable/equatable.dart';
import 'package:obfuscation_controller/app/data/auth/source/local/db_user_table.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';

class DBUserTableDTO extends Equatable {
  final String username;
  final int age;

  const DBUserTableDTO({
    required this.username,
    required this.age,
  });

  @override
  List<Object?> get props => [username, age];

  factory DBUserTableDTO.fromJson({required Map<String, Object?> json}) {
    try {
      return DBUserTableDTO(
        username: json[DBUserTable.username] as String,
        age: json[DBUserTable.age] as int,
      );
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.deserializationError,
      );
    }
  }

  Map<String, Object?> toJson() {
    try {
      return {
        DBUserTable.username: username,
        DBUserTable.age: age,
      };
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.serializationError,
      );
    }
  }
}
