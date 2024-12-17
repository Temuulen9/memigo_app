import 'package:memigo/api/lib/log.dart';
import '../api/api/api_helper.dart';

class Globals {
  static Globals? _instance;

  factory Globals() {
    _instance ??= Globals._internal();
    return _instance!;
  }

  Globals._internal();

  Future<void> init() async {
    apiHelper = ApiHelper()
      ..init(
          pApiUrls: gApiUrls,
          pLangId: 'mn',
          pMsgError: 'pMsgError',
          pMsgConnectionError: 'pMsgConnectionError',
          pMsgServiceUnavailable: 'pMsgServiceUnavailable',
          pMsgExecTimeout: 'pMsgExecTimeout',
          pMsgCheckInternet: 'pMsgCheckInternet',
          pUrlOption: UrlOption.dev,
          pNetworkConnectionChanged: () {
            log.d('pNetworkConnectionChanged');
          });
  }

  /// init everything here
}

ApiUrl gApiUrls = ApiUrl();

void appStart() {
  gApiUrls.addAll([
    ApiUrl(
      option: UrlOption.dev,
      desc: 'dev',
      baseUrl: 'https://tall-clam-44.deno.dev/api/',
      isProd: false,
    ),
  ]);
}
