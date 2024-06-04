import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/api/service/http_service.dart';

class ApiProvider {
  const ApiProvider._();

  /// Provider for [HttpService].
  static final httpServiceProvider = Provider<HttpService>((ref) {
    throw UnimplementedError();
  });
}
