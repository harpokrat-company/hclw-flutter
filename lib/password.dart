import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/asecret.dart';

class Password extends ASecret {
  Password(hclw, {Pointer<Void> secret})
      : super(hclw, secret ?? hclw.getAPIFunction('CreatePassword')());

  get name {
    return Utf8.fromUtf8(
        this.hclw.getAPIFunction('GetNameFromPassword')(this.secret));
  }

  set name(name) {
    this.hclw.getAPIFunction('UpdatePasswordName')(
        this.secret, Utf8.toUtf8(name));
  }

  get password {
    return Utf8.fromUtf8(
        this.hclw.getAPIFunction('GetPasswordFromPassword')(this.secret));
  }

  set password(password) {
    this.hclw.getAPIFunction('UpdatePasswordPassword')(
        this.secret, Utf8.toUtf8(password));
  }

  get login {
    return Utf8.fromUtf8(
        this.hclw.getAPIFunction('GetLoginFromPassword')(this.secret));
  }

  set login(login) {
    this.hclw.getAPIFunction('UpdatePasswordLogin')(
        this.secret, Utf8.toUtf8(login));
  }

  get domain {
    return Utf8.fromUtf8(
        this.hclw.getAPIFunction('GetDomainFromPassword')(this.secret));
  }

  set domain(domain) {
    this.hclw.getAPIFunction('UpdatePasswordDomain')(
        this.secret, Utf8.toUtf8(domain));
  }
}
