import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:obfuscation_controller/core/base/model/operation_result.dart';
import 'package:obfuscation_controller/core/error/enum/client_exception_type.dart';
import 'package:obfuscation_controller/core/error/model/client_failure.dart';

class FileSecurityService {
  const FileSecurityService();

  /// Hashes the [text] using SHA-256.
  ///
  /// Returns `null` when the hashing algorithm fails.
  OperationResult<String?> hash({required String text}) {
    try {
      final Digest computedHash = sha256.convert(utf8.encode(text));
      return OperationResult(data: computedHash.toString().toUpperCase(), failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.hashError,
          exception: ex,
        ),
      );
    }
  }

  /// Encrypts the given [plainText] using AES-256.
  ///
  /// Returns `null` when the encryption fails.
  OperationResult<String?> encrypt({required String plainText}) {
    try {
      final Key key = Key.fromLength(16);
      final IV iv = IV.fromLength(16);
      final Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);

      return OperationResult(data: encrypted.base64, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.encryptionError,
          exception: ex,
        ),
      );
    }
  }

  /// Decrypts the given [chiperText] using AES-256.
  ///
  /// Returns `null` when the decryption fails.
  OperationResult<String?> decrypt({required String chiperText}) {
    try {
      final Key key = Key.fromLength(16);
      final IV iv = IV.fromLength(16);
      final Encrypted encrypted = Encrypted.from64(chiperText);
      final Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

      final String plainText = encrypter.decrypt(encrypted, iv: iv);

      return OperationResult(data: plainText, failure: null);
    } catch (ex) {
      return OperationResult(
        data: null,
        failure: ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.decryptionError,
          exception: ex,
        ),
      );
    }
  }
}
