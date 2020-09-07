import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/hclw_flutter.dart';

class ASecret {
  HclwFlutter _hclw;
  Pointer<Void> _hclSecret;

  ASecret(this._hclw, String key, String serializedContent) {
    _hclSecret = _hclw.getAPIFunction('DeserializeSecret')(key, serializedContent);
  }

  get content {
    Pointer<Void> contentString =
        _hclw.getAPIFunction('GetContentStringFromPassword')(this._hclPassword);
    Pointer<Utf8> content =
        _hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    //_hclw.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
  }

  set name(name) {
    _hclw.getAPIFunction('UpdatePasswordName')(
        this._hclPassword, Utf8.toUtf8(name));
  }

  delete() {
    _hclw.getAPIFunction('DeleteSecret')(this._hclSecret);
  }
}
