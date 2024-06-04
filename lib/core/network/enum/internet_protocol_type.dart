import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';

enum InternetProtocolType {
  http,
  https;

  const InternetProtocolType();

  /// Creates a [InternetProtocolType] from [index].
  ///
  /// Returns `null` when the enum is not found.
  static InternetProtocolType? getInternetProtocolByIndex({required int? index}) {
    try {
      return values.firstWhere((element) => element.index == index);
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
