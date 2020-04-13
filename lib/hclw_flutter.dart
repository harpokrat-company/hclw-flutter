import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

typedef fncPtrFrm2ChrArr = Pointer<Void> Function(Pointer<Utf8>, Pointer<Utf8>);
typedef fncPtrFrm4ChrArr = Pointer<Void> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);
typedef fncChrArrFrmPtr = Pointer<Utf8> Function(Pointer<Void>);
typedef fncVdFrmPtr = Void Function(Pointer<Void>);
typedef fncUint8FrmPtr = Uint8 Function(Pointer<Void>);
typedef fncUint8FrmPtrDart = int Function(Pointer<Void>);
typedef fncPtrFrmVoid = Pointer<Void>Function();
typedef fncVdFrmPtrDart = void Function(Pointer<Void>);
typedef fncPtrFrmChrArr = Pointer<Void> Function(Pointer<Utf8>);
typedef fncVdFrmPtrAndChrArr = Void Function(Pointer<Void>, Pointer<Utf8>);
typedef fncVdFrmPtrAndChrArrDart = void Function(Pointer<Void>, Pointer<Utf8>);

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
    // Secret functions
    this._hclAPI['GetSecretFromContent'] = this._hcl.lookup<NativeFunction<fncPtrFrmChrArr>>('GetSecretFromContent').asFunction<fncPtrFrmChrArr>();
    this._hclAPI['CreateSecret'] = this._hcl.lookup<NativeFunction<fncPtrFrmVoid>>('CreateSecret').asFunction<fncPtrFrmVoid>();
    this._hclAPI['GetNameFromSecret'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetNameFromSecret').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['CorrectSecretDecryption'] = this._hcl.lookup<NativeFunction<fncUint8FrmPtr>>('CorrectSecretDecryption').asFunction<fncUint8FrmPtrDart>();
    this._hclAPI['GetLoginFromSecret'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetLoginFromSecret').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetPasswordFromSecret'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetPasswordFromSecret').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetDomainFromSecret'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetDomainFromSecret').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['GetContentStringFromSecret'] = this._hcl.lookup<NativeFunction<fncChrArrFrmPtr>>('GetContentStringFromSecret').asFunction<fncChrArrFrmPtr>();
    this._hclAPI['UpdateSecretName'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdateSecretName').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdateSecretLogin'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdateSecretLogin').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdateSecretPassword'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdateSecretPassword').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['UpdateSecretDomain'] = this._hcl.lookup<NativeFunction<fncVdFrmPtrAndChrArr>>('UpdateSecretDomain').asFunction<fncVdFrmPtrAndChrArrDart>();
    this._hclAPI['DeleteSecret'] = this._hcl.lookup<NativeFunction<fncVdFrmPtr>>('DeleteSecret').asFunction<fncVdFrmPtrDart>();
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
  }

  getAPIFunction(String functionName) {
    return this._hclAPI[functionName];
  }

  getDerivedKey(String key) {
    Pointer<Void> contentString = this.getAPIFunction('GetDerivedKey')(Utf8.toUtf8(key));
    Pointer<Utf8> content = this.getAPIFunction('GetCharArrayFromString')(contentString);
    this.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
  }

  getBasicAuth(String email, String key) {
    Pointer<Void> contentString = this.getAPIFunction('GetBasicAuthString')(Utf8.toUtf8(email), Utf8.toUtf8(key));
    Pointer<Utf8> content = this.getAPIFunction('GetCharArrayFromString')(contentString);
    this.getAPIFunction('DeleteString')(contentString);
    return Utf8.fromUtf8(content);
  }

  static const MethodChannel _channel = const MethodChannel('hclw_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
