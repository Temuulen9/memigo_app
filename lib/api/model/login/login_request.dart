import 'package:memigo/api/lib/func.dart';

import '../base/base.dart';

//class MgLoginView   {
//
//  bool rememberMe;
//  String pinClear;
//
//}

class MgLoginReq extends BaseRequest {
  String? phoneNumber;
  String? password;

  /// not api member
  /// view model member
  bool? rememberMe;
  String? pinClear;
  String? countryId;
  String? phonePrefix;

  MgLoginReq(
      {this.phoneNumber,
      this.password,

      /// not api member
      this.rememberMe,
      this.pinClear,
      this.countryId,
      this.phonePrefix});

  MgLoginReq copy() {
    return MgLoginReq(
      phoneNumber: phoneNumber,
      password: password,

      /// not api member
      rememberMe: rememberMe,
      pinClear: pinClear,
      countryId: countryId,
      phonePrefix: phonePrefix,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'phoneNumber': (Func.isNotNullEmpty(countryId) && countryId == 'MNG')
            ? phoneNumber
            : '$phonePrefix$phoneNumber',
        'password': password,
      };
}

//
//class MgLoginReq extends BaseRequest {
//  String loginCode;
//  String custCredValue;
//  String deviceId;
//  String deviceName;
//  String deviceIp;
//  String deviceMac;
//  String osType;
//  String osVersion;
//  int appVersion;
////  @override
////  String lang;
//  int isReLogin;
//  int biometricFlag;
//  String pushToken;
//  String traceNo;
//  double latitude;
//  double longitude;
//  int isLite;
//
//  MgLoginReq({
//    this.loginCode,
//    this.custCredValue,
//    this.deviceId,
//    this.deviceName,
//    this.deviceIp,
//    this.deviceMac,
//    this.osType,
//    this.osVersion,
//    this.appVersion,
//    String lang,
//    this.isReLogin,
//    this.biometricFlag,
//    this.pushToken,
//    this.traceNo,
//    this.latitude,
//    this.longitude,
//    this.isLite,
//  }):super(lang: lang);
//
//  @override
//  Map<String, dynamic> toJson() => {
//    'loginCode': loginCode,
//    'custCredValue': custCredValue,
//    'deviceId': deviceId,
//    'deviceName': deviceName,
//    'deviceIp': deviceIp,
//    'deviceMac': deviceMac,
//    'osType': osType,
//    'osVersion': osVersion,
//    'appVersion': appVersion,
//    'isReLogin': isReLogin,
//    'biometricFlag': biometricFlag,
//    'pushToken': pushToken,
//    'traceNo': traceNo,
//    'latitude': latitude,
//    'longitude': longitude,
//    'isLite': isLite,
//  }..addAll(super.toJson());
//}
