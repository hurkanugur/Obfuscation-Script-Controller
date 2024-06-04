import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obfuscation_controller/core/security/service/file_security_service.dart';

class SecurityProvider {
  const SecurityProvider._();

  /// Provider for [FileSecurityService].
  static final fileSecurityServiceProvider = Provider<FileSecurityService>((ref) {
    return const FileSecurityService();
  });
}
