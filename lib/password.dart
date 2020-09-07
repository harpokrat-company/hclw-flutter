import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/hclw_flutter.dart';

class Password {
  HclwFlutter _hclw;
  Pointer<Void> _hclPassword;

  Password(this._hclw,  String serializedContent) {
    _hclPassword = _hclw.getAPIFunction('CreatePassword')();
  }

  get content {
    Pointer<Void> contentString =
        _hclw.getAPIFunction('GetContentStringFromPassword')(this._hclPassword);
    Pointer<Utf8> content =
        _hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    //_hclw.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
  }

  get name {
    return Utf8.fromUtf8(
        _hclw.getAPIFunction('GetNameFromPassword')(this._hclPassword));
  }

  set name(name) {
    _hclw.getAPIFunction('UpdatePasswordName')(
        this._hclPassword, Utf8.toUtf8(name));
  }

  get password {
    return Utf8.fromUtf8(
        _hclw.getAPIFunction('GetPasswordFromPassword')(this._hclPassword));
  }

  set password(password) {
    _hclw.getAPIFunction('UpdatePasswordPassword')(
        this._hclPassword, Utf8.toUtf8(password));
  }

  get login {
    return Utf8.fromUtf8(
        _hclw.getAPIFunction('GetLoginFromPassword')(this._hclPassword));
  }

  set login(login) {
    _hclw.getAPIFunction('UpdatePasswordLogin')(
        this._hclPassword, Utf8.toUtf8(login));
  }

  get domain {
    return Utf8.fromUtf8(
        _hclw.getAPIFunction('GetDomainFromPassword')(this._hclPassword));
  }

  set domain(domain) {
    _hclw.getAPIFunction('UpdatePasswordDomain')(
        this._hclPassword, Utf8.toUtf8(domain));
  }

  get correctPasswordDecryption {
    return _hclw.getAPIFunction('CorrectPasswordDecryption')(this._hclPassword);
  }

  delete() {
    _hclw.getAPIFunction('DeletePassword')(this._hclPassword);
  }
}
