import 'dart:ffi';
import 'package:hclw_flutter/rsaprivatekey.dart';
import 'package:hclw_flutter/rsapublickey.dart';
import 'hclw_flutter.dart';

class RSAKeyPair {
  HclwFlutter _hclw;
  Pointer<Void> _hclRSAKeyPair;

  RSAKeyPair(this._hclw, int bits) {
    _hclRSAKeyPair = this._hclw.getAPIFunction('GenerateRSAKeyPair')(bits);
  }

  createPrivateKey() {
    return new RSAPrivateKey(
        this._hclw,
        this._hclw.getAPIFunction('GetPrivateKeyFromRSAKeyPair')(
            this._hclRSAKeyPair));
  }

  createPublicKey() {
    return new RSAPublicKey(
        this._hclw,
        this._hclw.getAPIFunction('GetPublicKeyFromRSAKeyPair')(
            this._hclRSAKeyPair));
  }

  delete() {
    _hclw.getAPIFunction('DeleteRSAKeyPair')(this._hclRSAKeyPair);
  }
}
