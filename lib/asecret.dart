import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/hclw_flutter.dart';
import 'package:hclw_flutter/rsapublickey.dart';

class ASecret {
  HclwFlutter _hclw;
  Pointer<Void> _hclSecret;

  ASecret(this._hclw, this._hclSecret);

  serialize(String encryptionKey) {
    Pointer<Void> contentString = _hclw.getAPIFunction('SerializeSecret')(this._hclSecret, Utf8.toUtf8(encryptionKey));
    Pointer<Utf8> content = _hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    final r = Utf8.fromUtf8(content);
    _hclw.getAPIFunction('DeleteString')(contentString);
    return r;
  }

  serializeAsymmetric(RSAPublicKey encryptionKey) {
    Pointer<Void> rsa_key = _hclw.getAPIFunction('ExtractKeyFromPublicKey')(encryptionKey.secret);
    Pointer<Void> contentString = _hclw.getAPIFunction('SerializeSecretAsymmetric')(this._hclSecret, rsa_key);
    _hclw.getAPIFunction('DeleteRSAKey')(rsa_key);
    Pointer<Utf8> content = _hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    final r = Utf8.fromUtf8(content);
    _hclw.getAPIFunction('DeleteString')(contentString);
    return r;
  }

  initializeAsymmetric() {
    _hclw.getAPIFunction('SecretInitializeAsymmetricCipher')(this._hclSecret);
  }

  initializeSymmetric() {
    _hclw.getAPIFunction('SecretInitializeSymmetricCipher')(this._hclSecret);
  }

  get typeName {
    Pointer<Void> contentString = _hclw.getAPIFunction('GetSecretTypeName')(this._hclSecret);
    Pointer<Utf8> content = _hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    _hclw.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
  }

  get correctDecryption {
    return this.hclw.getAPIFunction('GetSecretCorrectDecryption')(
        this._hclSecret
    );
  }

  get secret {
    return this._hclSecret;
  }

  get hclw {
    return this._hclw;
  }

  delete() {
    _hclw.getAPIFunction('DeleteSecret')(this._hclSecret);
  }
}
