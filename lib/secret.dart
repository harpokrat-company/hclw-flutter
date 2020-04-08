import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/hclw_flutter.dart';

class Secret {
  HclwFlutter _hclw;
  Pointer<Void> _hclSecret;

  Secret(this._hclw, {String key, String content}) {
    if (key != null && content != null)
      _hclSecret = _hclw.getAPIFunction('GetSecretFromContent')(Utf8.toUtf8(key), Utf8.toUtf8(content));
    else
      _hclSecret = _hclw.getAPIFunction('CreateSecret')();
  }

  get content {
    Pointer<Void> contentString = _hclw.getAPIFunction('GetContentStringFromSecret')(this._hclSecret);
    Pointer<Utf8> content = _hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    _hclw.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
  }

  get name {
    return Utf8.fromUtf8(_hclw.getAPIFunction('GetNameFromSecret')(this._hclSecret));
  }

  set name(name) {
    _hclw.getAPIFunction('UpdateSecretName')(this._hclSecret, Utf8.toUtf8(name));
  }

  get password {
    return Utf8.fromUtf8(_hclw.getAPIFunction('GetPasswordFromSecret')(this._hclSecret));
  }

  set password(password) {
    _hclw.getAPIFunction('UpdateSecretPassword')(this._hclSecret, Utf8.toUtf8(password));
  }

  get login {
    return Utf8.fromUtf8(_hclw.getAPIFunction('GetLoginFromSecret')(this._hclSecret));
  }

  set login(login) {
    _hclw.getAPIFunction('UpdateSecretLogin')(this._hclSecret, Utf8.toUtf8(login));
  }

  get domain {
    return Utf8.fromUtf8(_hclw.getAPIFunction('GetDomainFromSecret')(this._hclSecret));
  }

  set domain(domain) {
    _hclw.getAPIFunction('UpdateSecretDomain')(this._hclSecret, Utf8.toUtf8(domain));
  }

  get correctSecretDecryption {
    return _hclw.getAPIFunction('CorrectSecretDecryption')(this._hclSecret);
  }

  delete() {
    _hclw.getAPIFunction('DeleteSecret')(this._hclSecret);
  }
}
