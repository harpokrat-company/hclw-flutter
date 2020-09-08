import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/asecret.dart';

class RSAPrivateKey extends ASecret {
  RSAPrivateKey(hclw, Pointer<Void> secret) : super(hclw, secret);

  get owner {
    return Utf8.fromUtf8(
        this.hclw.getAPIFunction('GetOwnerFromPrivateKey')(this.secret));
  }

  set owner(owner) {
    this.hclw.getAPIFunction('SetPrivateKeyOwner')(
        this.secret, Utf8.toUtf8(owner));
  }

  decryptMessage(String message) {
    Pointer<Void> contentString =
        this.hclw.getApiFunction('DecryptMessageWithPrivateKey')(
            this.secret, Utf8.toUtf8(message));
    Pointer<Utf8> content =
        this.hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    this.hclw.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
  }
}
