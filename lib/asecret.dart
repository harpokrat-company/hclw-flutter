import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/hclw_flutter.dart';

class ASecret {
  HclwFlutter _hclw;
  Pointer<Void> _hclSecret;

  ASecret(this._hclw, this._hclSecret);

  serialize(String encryptionKey) {
    Pointer<Void> contentString = _hclw.getAPIFunction('SerializeSecret')(this._hclSecret, Utf8.toUtf8(encryptionKey));
    Pointer<Utf8> content = _hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    _hclw.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
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
