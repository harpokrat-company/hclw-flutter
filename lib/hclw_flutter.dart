import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:hclw_flutter/asecret.dart';
import 'package:hclw_flutter/password.dart';
import 'package:hclw_flutter/rsaprivatekey.dart';
import 'package:hclw_flutter/rsapublickey.dart';
import 'package:hclw_flutter/symmetrickey.dart';

typedef fncPtrFrm2ChrArr = Pointer<Void> Function(Pointer<Utf8>, Pointer<Utf8>);
typedef fncPtrFrm4ChrArr = Pointer<Void> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);
typedef fncChrArrFrmPtr = Pointer<Utf8> Function(Pointer<Void>);
typedef fncVdFrmPtr = Void Function(Pointer<Void>);
typedef fncVdFrmPtrDart = void Function(Pointer<Void>);
typedef fncUint8FrmPtr = Uint8 Function(Pointer<Void>);
typedef fncIntFrmPtrDart = int Function(Pointer<Void>);
typedef fncPtrFrmVoid = Pointer<Void>Function();
typedef fncPtrFrmUint64 = Pointer<Void>Function(Uint64);
typedef fncPtrFrmIntDart = Pointer<Void>Function(int);
typedef fncPtrFrmChrArr = Pointer<Void> Function(Pointer<Utf8>);
typedef fncPtrFrmPtrDart = Pointer<Void> Function(Pointer<Void>);
typedef fncPtrFrm2PtrDart = Pointer<Void> Function(Pointer<Void>, Pointer<Void>);
typedef fncPtrFrmVd = Pointer<Void> Function(Void);
typedef fncVdFrmPtrAndChrArr = Void Function(Pointer<Void>, Pointer<Utf8>);
typedef fncVdFrmPtrAndChrArrDart = void Function(Pointer<Void>, Pointer<Utf8>);
typedef fncPtrFrmPtrAndChrArr = Pointer<Void> Function(Pointer<Void>, Pointer<Utf8>);

class HclwFlutter {
  DynamicLibrary _hcl;
  Map _hclAPI;

  HclwFlutter() {
    this._hcl = Platform.isAndroid
        ? DynamicLibrary.open('libhcl.so')
        : DynamicLibrary.process();
    this._hclAPI = Map();
    this._initializeAPI();
  }

  _initializeAPI() {
    // String functions
    this._hclAPI['GetBasicAuthString'] = this._hcl.lookup<NativeFunction<fncPtrFrm2ChrArr>>('GetBasicAuthString').asFunction<fncPtrFrm2ChrArr>();
    this._hclAPI['GetDerivedKey'] = this._hcl.lookup<NativeFunction<fncPtrFrm2ChrArr>>('GetDerivedKey').asFunction<fncPtrFrm2ChrArr>();
    this._hclAPI['GetCharArrayFromString'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetCharArrayFromString').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['DeleteString'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('DeleteString').asFunction<fncVdFrmPtrDart>();
    // User functions
    this._hclAPI['CreateUser'] = this._hcl.lookup<NativeFunction<fncPtrFrm4ChrArr>>('CreateUser').asFunction<fncPtrFrm4ChrArr>();
    this._hclAPI['GetEmailFromUser'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetEmailFromUser').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetPasswordFromUser'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetPasswordFromUser').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetFirstNameFromUser'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetFirstNameFromUser').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetLastNameFromUser'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetLastNameFromUser').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['UpdateUserEmail'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdateUserEmail').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdateUserPassword'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdateUserPassword').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdateUserFirstName'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdateUserFirstName').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdateUserLastName'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdateUserLastName').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['DeleteUser'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('DeleteUser').asFunction<fncVdFrmPtrDart>();
    // RSAKeyPair functions
    this._hclAPI['GenerateRSAKeyPair'] = this._hcl.lookup<NativeFunction<fncPtrFrmUint64>>('GenerateRSAKeyPair').asFunction<fncPtrFrmIntDart>();
    this._hclAPI['GetPublicKeyFromRSAKeyPair'] = this._hcl.lookup<NativeFunction<fncPtrFrmPtrDart>>('GetPublicKeyFromRSAKeyPair').asFunction<fncPtrFrmPtrDart>();
    this._hclAPI['GetPrivateKeyFromRSAKeyPair'] = this._hcl.lookup<NativeFunction<fncPtrFrmPtrDart>>('GetPrivateKeyFromRSAKeyPair').asFunction<fncPtrFrmPtrDart>();
    this._hclAPI['DeleteRSAKeyPair'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('DeleteRSAKeyPair').asFunction<fncVdFrmPtrDart>();
    // ASecret functions
    this._hclAPI['DeserializeSecret'] = this._hcl.lookup<NativeFunction<fncPtrFrm2ChrArr>>('DeserializeSecret').asFunction<fncPtrFrm2ChrArr>();
    this._hclAPI['SerializeSecret'] = this._hcl.lookup<NativeFunction<fncPtrFrm2ChrArr>>('SerializeSecret').asFunction<fncPtrFrm2ChrArr>();
    this._hclAPI['DeserializeSecretAsymmetric'] = this._hcl.lookup<NativeFunction<fncPtrFrmPtrAndChrArr>>('DeserializeSecretAsymmetric').asFunction<fncPtrFrmPtrAndChrArr>();
    this._hclAPI['SerializeSecretAsymmetric'] = this._hcl.lookup<NativeFunction<fncPtrFrm2PtrDart>>('SerializeSecretAsymmetric').asFunction<fncPtrFrm2PtrDart>();
    this._hclAPI['GetSecretCorrectDecryption'] = this._hcl.lookup<NativeFunction<fncUint8FrmPtr>>('GetSecretCorrectDecryption').asFunction<fncIntFrmPtrDart>();
    this._hclAPI['SecretInitializePlainCipher'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('SecretInitializePlainCipher').asFunction<fncVdFrmPtrDart>();
    this._hclAPI['SecretInitializeAsymmetricCipher'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('SecretInitializeAsymmetricCipher').asFunction<fncVdFrmPtrDart>();
    this._hclAPI['SecretInitializeSymmetricCipher'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('SecretInitializeSymmetricCipher').asFunction<fncVdFrmPtrDart>();
    this._hclAPI['GetSecretTypeName'] = this._hcl.lookup<NativeFunction<fncPtrFrmPtrDart>>('GetSecretTypeName').asFunction<fncPtrFrmPtrDart>();
    this._hclAPI['DeleteSecret'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('DeleteSecret').asFunction<fncVdFrmPtrDart>();
    // Password functions
    this._hclAPI['CreatePassword'] = this._hcl.lookup<NativeFunction<fncPtrFrmVoid>>('CreatePassword').asFunction<fncPtrFrmVoid>();
    this._hclAPI['GetNameFromPassword'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetNameFromPassword').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetLoginFromPassword'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetLoginFromPassword').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetPasswordFromPassword'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetPasswordFromPassword').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetDomainFromPassword'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetDomainFromPassword').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['UpdatePasswordName'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdatePasswordName').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdatePasswordLogin'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdatePasswordLogin').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdatePasswordPassword'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdatePasswordPassword').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdatePasswordDomain'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdatePasswordDomain').asFunction<fncVdFrmPtrAndChrArrDart>();
    // RSAPrivateKey functions
    this._hclAPI['GetOwnerFromPrivateKey'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetOwnerFromPrivateKey').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['SetPrivateKeyOwner'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('SetPrivateKeyOwner').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['DecryptMessageWithPrivateKey'] = this._hcl.lookup<NativeFunction<fncPtrFrmPtrAndChrArr>>('DecryptMessageWithPrivateKey').asFunction<fncPtrFrmPtrAndChrArr>();
    this._hclAPI['ExtractKeyFromPrivateKey'] = this._hcl.lookup<NativeFunction<fncPtrFrmPtrDart>>('ExtractKeyFromPrivateKey').asFunction<fncPtrFrmPtrDart>();
    // RSAPublicKey functions
    this._hclAPI['GetOwnerFromPublicKey'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetOwnerFromPublicKey').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['SetPublicKeyOwner'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('SetPublicKeyOwner').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['EncryptMessageWithPublicKey'] = this._hcl.lookup<NativeFunction<fncPtrFrmPtrAndChrArr>>('EncryptMessageWithPublicKey').asFunction<fncPtrFrmPtrAndChrArr>();
    this._hclAPI['ExtractKeyFromPublicKey'] = this._hcl.lookup<NativeFunction<fncPtrFrmPtrDart>>('ExtractKeyFromPublicKey').asFunction<fncPtrFrmPtrDart>();
    // SymmetricKey functions
    this._hclAPI['CreateSymmetricKey'] = this._hcl.lookup<NativeFunction<fncPtrFrmVoid>>('CreateSymmetricKey').asFunction<fncPtrFrmVoid>();
    this._hclAPI['GetOwnerFromSymmetricKey'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetOwnerFromSymmetricKey').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['SetSymmetricKeyOwner'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('SetSymmetricKeyOwner').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['GetKeyFromSymmetricKey'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetKeyFromSymmetricKey').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['SetSymmetricKeyKey'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('SetSymmetricKeyKey').asFunction<fncVdFrmPtrAndChrArrDart>();
    // RSAKey functions
    this._hclAPI['DeleteRSAKey'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('DeleteRSAKey').asFunction<fncVdFrmPtrDart>();
  }

  getAPIFunction(String functionName) {
    if (this._hclAPI.containsKey(functionName))
      return this._hclAPI[functionName];
    return null;
  }

  getDerivedKey(String key) {
    Pointer<Void> contentString = this.getAPIFunction('GetDerivedKey')(Utf8.toUtf8(key));
    Pointer<Utf8> content = this.getAPIFunction('GetCharArrayFromString')(contentString);
    final r = Utf8.fromUtf8(content);
    this.getAPIFunction('DeleteString')(contentString);
    return r;
  }

  getBasicAuth(String email, String key) {
    Pointer<Void> contentString = this.getAPIFunction('GetBasicAuthString')(Utf8.toUtf8(email), Utf8.toUtf8(key));
    Pointer<Utf8> content = this.getAPIFunction('GetCharArrayFromString')(contentString);
    final r = Utf8.fromUtf8(content);
    this.getAPIFunction('DeleteString')(contentString);
    return r;
  }

  autoCastSecret(Pointer<Void> secret) {
    Pointer<Void> contentString = this.getAPIFunction('GetSecretTypeName')(secret);
    Pointer<Utf8> typeNamePtr = this.getAPIFunction('GetCharArrayFromString')(contentString);
    final typeName = Utf8.fromUtf8(typeNamePtr);
    this.getAPIFunction('DeleteString')(contentString);
    switch (typeName) {
      case "password": {
        return new Password(this, secret: secret);
      }
      break;
      case "private-key": {
        return new RSAPrivateKey(this, secret);
      }
      break;
      case "public-key": {
        return new RSAPublicKey(this, secret);
      }
      break;
      case "symmetric-key": {
        return new SymmetricKey(this, secret: secret);
      }
      break;
    }
  }

  deserializeSecret(String key, String serializedContent) {
    Pointer<Void> secret = this.getAPIFunction('DeserializeSecret')(Utf8.toUtf8(key), Utf8.toUtf8(serializedContent));
    return autoCastSecret(secret);
  }

  deserializeSecretAsymmetric(RSAPrivateKey key, String serializedContent) {
    Pointer<Void> rsaKey = this.getAPIFunction('ExtractKeyFromPrivateKey')(key.secret);
    Pointer<Void> secret = this.getAPIFunction('DeserializeSecretAsymmetric')(rsaKey, Utf8.toUtf8(serializedContent));
    this.getAPIFunction('DeleteRSAKey')(rsaKey);
    return autoCastSecret(secret);
  }

  static const MethodChannel _channel = const MethodChannel('hclw_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
