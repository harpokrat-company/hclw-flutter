import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/hclw_flutter.dart';

class User {
  HclwFlutter _hclw;
  Pointer<Void> _hclUser;

  User(this._hclw, String email, String password, String firstName, String lastName) {
    _hclUser = _hclw.getAPIFunction('CreateUserUser')(Utf8.toUtf8(email), Utf8.toUtf8(password), Utf8.toUtf8(firstName), Utf8.toUtf8(lastName));
  }

  get email {
    return Utf8.fromUtf8(_hclw.getAPIFunction('GetEmailFromUser')(this._hclUser));
  }

  set email(email) {
    _hclw.getAPIFunction('UpdateUserEmail')(this._hclUser, Utf8.toUtf8(email));
  }

  get password {
    return Utf8.fromUtf8(_hclw.getAPIFunction('GetPasswordFromUser')(this._hclUser));
  }

  set password(password) {
    _hclw.getAPIFunction('UpdateUserPassword')(this._hclUser, Utf8.toUtf8(password));
  }

  get firstName {
    return Utf8.fromUtf8(_hclw.getAPIFunction('GetFirstNameFromUser')(this._hclUser));
  }

  set firstName(firstName) {
    _hclw.getAPIFunction('UpdateUserFirstName')(this._hclUser, Utf8.toUtf8(firstName));
  }

  get lastName {
    return Utf8.fromUtf8(_hclw.getAPIFunction('GetLastNameFromUser')(this._hclUser));
  }

  set lastName(lastName) {
    _hclw.getAPIFunction('UpdateUserLastName')(this._hclUser, Utf8.toUtf8(lastName));
  }

  delete() {
    _hclw.getAPIFunction('DeleteUser')(this._hclUser);
  }
}