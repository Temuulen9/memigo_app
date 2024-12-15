import '../memigo_core.dart';

export './api_helper.dart';
export './api_url.dart';

class Api {
  static Future<MgLoginRes> login(MgLoginReq request) async {
    return MgLoginRes.fromJson(
        (await apiHelper.post(ApiOper.login, request)).data);
  }

  static Future<BaseResponse> logout(BaseRequest request) async {
    return BaseResponse.fromJson(
        (await apiHelper.post(ApiOper.logout, request)).data);
  }
}
