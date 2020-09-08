import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/asecret.dart';

class SymmetricKey extends ASecret {
  SymmetricKey(hclw, {Pointer<Void> secret})
      : super(hclw, secret ?? hclw.getAPIFunction('CreateSymmetricKey')());

  get owner {
    return Utf8.fromUtf8(
        this.hclw.getAPIFunction('GetOwnerFromSymmetricKey')(this.secret));
  }

  set owner(owner) {
    this.hclw.getAPIFunction('SetSymmetricKeyOwner')(
        this.secret, Utf8.toUtf8(owner));
  }

  get key {
    return Utf8.fromUtf8(
        this.hclw.getAPIFunction('GetKeyFromSymmetricKey')(this.secret));
  }

  set key(key) {
    this.hclw.getAPIFunction('SetSymmetricKeyKey')(
        this.secret, Utf8.toUtf8(key));
  }
}
