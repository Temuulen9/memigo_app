import '../base/base.dart';

class MgLoginRes extends BaseResponse {
  String? sessionId;
  String? custId;
  String? custName;
  String? email;
  String? mobile;
  String? lastAccessDatetime;
  String? lastAccessDeviceIp;
  String? lastAccessDeviceName;
  int? clearPush;
  String? vatUserNo;
  String? fbAppId;
  String? picture;
  int? isLoggedInFp;
  String? faqIdFp;
  String? credStatus;
  int? isDuplicated;
  int? expireTimeout;
  String? parentCustId;
  String? custType;
  int? appVersion;

  /// login component
  String? rememberme;
  String? op;
  String? mobileWithPrefix;
  String? pwdStatus;
  int? hasPwd;

  MgLoginRes({
    this.sessionId,
    this.custId,
    this.custName,
    this.email,
    this.mobile,
    this.mobileWithPrefix,
    this.lastAccessDatetime,
    this.lastAccessDeviceIp,
    this.lastAccessDeviceName,
    this.clearPush,
    this.vatUserNo,
    this.fbAppId,
    this.picture,
    this.isLoggedInFp,
    this.faqIdFp,
    this.credStatus,
    this.isDuplicated,
    this.expireTimeout,
    this.parentCustId,
    this.custType,
    this.appVersion,
    this.rememberme,
    this.op,
    this.hasPwd,
    this.pwdStatus,
  });

  factory MgLoginRes.fromJson(Map<String, dynamic> json) => MgLoginRes(
        sessionId: json['sessionId'] ?? json['sessionToken'],
        custId: json['custId'],
        custName: json['custName'],
        email: json['email'],
        mobile: json['mobile'] ?? json['msisdn'],
        mobileWithPrefix: json['mobile'] ?? json['msisdn'],
        lastAccessDatetime: json['lastAccessDatetime'] ?? json['accessDate'],
        lastAccessDeviceIp: json['lastAccessDeviceIp'],
        lastAccessDeviceName: json['lastAccessDeviceName'],
        clearPush: json['clearPush'],
        vatUserNo: json['vatUserNo'],
        fbAppId: json['fbAppId'],
        picture: json['picture'],
        isLoggedInFp: json['isLoggedInFp'],
        faqIdFp: json['faqIdFp'],
        credStatus: json['credStatus'],
        isDuplicated: json['isDuplicated'],
        expireTimeout: json['expireTimeout'],
        parentCustId: json['parentCustId'],
        custType: json['custType'],
        rememberme: json['rememberme'],
        op: json['op'],
        appVersion: json['appVersion'] ?? 0,
        hasPwd: json['hasPwd'] ?? 0,
        pwdStatus: json['pwdStatus'] ?? '',
      )..fromJson(json);

  @override
  String toString() => 'MgLoginRes { mobile: $mobile, sessionId: $sessionId, rememberme: $rememberme, op: $op }';
}
//
// class MgLoginComponentRes extends MgLoginRes {
//
//   bool rememberme;
//   String op;
//
//   //MgLoginComponentRes({this.op, this.data});
//
//   // factory MgLoginComponentRes.fromJson(Map<String, dynamic> json) => MgLoginComponentRes(op: json['op'], data: json['data'] == null ? MgLoginRes() : MgLoginRes.fromJson(json['data']));
//   //
//   // void fromJson(Map<String, dynamic> json) {
//   //   orgResponseCode = json['responseCode'];
//   //   responseCode = json['responseCode'];
//   //   responseDesc = json['responseDesc'];
//   // }
//
//   // factory MgLoginComponentRes.fromJson(Map<String, dynamic> json) {
//   //
//   //   return MgLoginRes.fromJson(json)..op; //..op=json['custId'];
//   //
//   //   sessionId: json['sessionId'] ?? json['sessionToken']
//   // }
//
//
//   MgLoginComponentRes({
//     this.rememberme,
//     this.op,
//   });
//
//
//   factory MgLoginComponentRes.fromJson(Map<String, dynamic> json) => MgLoginComponentRes(
//
//     rememberme: json['rememberme'],
//     op: json['op'],
//   )..fromJson(json);
//
//   @override
//   String toString() => 'MgLoginComponentRes { op: $op, MgLoginRes: $data }';
// }
