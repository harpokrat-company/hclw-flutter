import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:hclw_flutter/asecret.dart';

class RSAPublicKey extends ASecret {
  RSAPublicKey(hclw, Pointer<Void> secret) : super(hclw, secret);

  get owner {
    return Utf8.fromUtf8(
        this.hclw.getAPIFunction('GetOwnerFromPublicKey')(this.secret));
  }

  set owner(owner) {
    this.hclw.getAPIFunction('SetPublicKeyOwner')(
        this.secret, Utf8.toUtf8(owner));
  }

  encryptMessage(String message) {
    Pointer<Void> contentString =
        this.hclw.getApiFunction('EncryptMessageWithPublicKey')(
            this.secret, Utf8.toUtf8(message));
    Pointer<Utf8> content =
        this.hclw.getAPIFunction('GetCharArrayFromString')(contentString);
    this.hclw.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
  }
}
