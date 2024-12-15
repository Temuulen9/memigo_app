class BaseResponse {
  // Success
  static const cSuccess = 0;

  // Failed
  static const cFailed = 8888;

  // Error occurred
  static const cError = 7777;

  // No data
  static const cNoData = 9999;

  //#endregion
  //#region [ Loan response codes ]

  static const lostConnection = 1111;

  //#endregion

  int responseCode;
  String responseDesc;

  // for view
  int? orgResponseCode = 1;

  bool get isSuccess => responseCode == 0;

  bool get isFailed => responseCode != 0;

  bool checkResponseCode(int checkResponseCode, {bool isTrue = true}) =>
      (isTrue)
          ? responseCode == checkResponseCode
          : responseCode != checkResponseCode;

  BaseResponse(
      {this.responseCode = 0, this.responseDesc = '', this.orgResponseCode});

  void fromJson(Map<String, dynamic>? json) {
    orgResponseCode = (json != null && json['responseCode'] != null)
        ? json['responseCode']
        : 999;
    responseCode = (json != null && json['responseCode'] != null)
        ? json['responseCode']
        : 999;
    responseDesc = (json != null && json['responseDesc'] != null)
        ? json['responseDesc']
        : '';
  }

  void fromObj(BaseResponse obj) {
    orgResponseCode = obj.responseCode;
    responseCode = obj.responseCode;
    responseDesc = obj.responseDesc;
  }

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      responseCode: json['responseCode'] ?? 999,
      orgResponseCode: json['responseCode'] ?? 999,
      responseDesc: json['responseDesc'] ?? '');

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['responseCode'] = responseCode;
    data['responseDesc'] = responseDesc;
    return data;
  }

  static Map<String, dynamic> json(int responseCode, String responseDesc) {
    return BaseResponse(responseCode: responseCode, responseDesc: responseDesc)
        .toJson();
  }

  @override
  String toString() {
    return '''BaseResponse {
        responseCode: $responseCode,
        responseDesc: $responseDesc,  
      }''';
  }
//BaseResponse.withError();
}
