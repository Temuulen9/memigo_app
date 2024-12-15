import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:memigo/api/lib/func.dart';
import 'package:memigo/api/lib/log.dart';

import '../model/base/base.dart';
import './api_connectivity.dart';
import './api_operation.dart';
import './api_url.dart';

export './api_url.dart';

///
/// global api helper variable
///
late ApiHelper apiHelper;

///
/// ApiHelper
///
class ApiHelper {
  var apiUrl = ApiUrl();

  /// current api url
  ApiUrl? currentApiUrl;

  // /// app secret
  // String appSecret; // = gAppSecretAndroid;
  //
  // /// app id ios | android
  // String appId; // = Platform.isAndroid ? gAppIdAndroid : gAppIdiOS; // (app.device?.isAndroid ?? true)

  Dio? _clientBase;
  late StreamSubscription _connectionChangeStream;
  var isOffline = false;
  var recTimeOut = 120;
  var recTimeOutLong = 120;
  var conTimeOut = 10;
  var conTimeOutLong = 30;
  var conTimeOutLongest = 60;

  var sessionId;
  var langId;
  Function? sessionExpireMethod;
  Function? networkConnectionChanged;
  Function? refreshSessionTimeOut;
  var msgError;
  var msgConnectionError;
  var msgServiceUnavailable;
  var msgExecTimeout;
  var msgCheckInternet;

  static ApiHelper? _instance;

  factory ApiHelper() {
    _instance ??= ApiHelper._internal();
    return _instance!;
  }

  ApiHelper._internal() {
    var connectionStatus = ConnectionStatusSingleton.getInstance()
      ..initialize();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
  }

  void init(
      {required String pLangId,
      // required Function pSessionExpireMethod,
      required String pMsgError,
      required String pMsgConnectionError,
      required String pMsgServiceUnavailable,
      required String pMsgExecTimeout,
      required String pMsgCheckInternet,
      required ApiUrl pApiUrls,
      required UrlOption pUrlOption,
      required Function pNetworkConnectionChanged,
      Function? pRefreshSessionTimeOut}) {
    langId = pLangId;
    // sessionExpireMethod = pSessionExpireMethod;
    networkConnectionChanged = pNetworkConnectionChanged;
    msgError = pMsgError;
    msgConnectionError = pMsgConnectionError;
    msgServiceUnavailable = pMsgServiceUnavailable;
    msgExecTimeout = pMsgExecTimeout;
    msgCheckInternet = pMsgCheckInternet;
    apiUrl = pApiUrls;
    refreshSessionTimeOut = pRefreshSessionTimeOut;

    _init(pUrlOption);
  }

  void cancel() {
    _connectionChangeStream.cancel();
  }

  /// refresh url option
  void refresh(UrlOption urlOption) {
    _init(urlOption, refresh: true);
  }

  /// For App store & Play Store app review test user
  String checkTestUserForAppReview(String mobile, String deviceId) {
    var prodTest = apiUrl.item(UrlOption.prodReview);

    if (prodTest != null && mobile == prodTest.testUserLoginCode) {
      refresh(UrlOption.prodReview);
      return 'empty!';
    } else {
      return deviceId;
    }
  }

  void updateMsg({
    required String pLangId,
    required String pMsgError,
    required String pMsgConnectionError,
    required String pMsgServiceUnavailable,
    required String pMsgExecTimeout,
    required String pMsgCheckInternet,
  }) {
    langId = pLangId;
    msgError = pMsgError;
    msgConnectionError = pMsgConnectionError;
    msgServiceUnavailable = pMsgServiceUnavailable;
    msgExecTimeout = pMsgExecTimeout;
    msgCheckInternet = pMsgCheckInternet;
  }

  /// init or refresh url changed
  void _init(UrlOption urlOption, {bool refresh = false}) {
    currentApiUrl = apiUrl.item(urlOption);
    log.d(
        '$runtimeType _init CALLED refresh: $refresh, urlOption=> $urlOption, apiUrl.count: ${apiUrl.count()} currentApiUrl=> $currentApiUrl');

    /// post base
    if (null == _clientBase || refresh) {
      var options = BaseOptions()
        ..baseUrl = currentApiUrl!.baseUrl
        ..receiveTimeout = Duration(seconds: recTimeOut) // 120second
        ..connectTimeout = Duration(seconds: conTimeOut) // 10second
        ..contentType = Headers
            .jsonContentType //  'Content-Type': 'application/json; charset=utf-8',
        ..headers = !kIsWeb
            ? <String, String>{
                'connection': 'Close',
                'accept': 'application/json',
                'accept-charset': 'utf-8',
              }
            : <String, String>{
                'accept': 'application/json',
              };

      _clientBase = Dio(options);
      _clientBase!.interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ));
    }
  }

  /// general post method
  Future<Response> _post(
      Dio? client, String operCode, BaseRequest request) async {
    // ignore: missing_required_param
    var response = Response<dynamic>(
        requestOptions: RequestOptions(path: client?.options.baseUrl ?? ''));
    // assert(request != null);
    var baseResponse = BaseResponse();
    try {
      if (isOffline) {
        response.statusCode = 400;
        baseResponse = BaseResponse(
            responseCode: cERR_911,
            responseDesc:
                getErrMsg(cERR_911, showDetail: !currentApiUrl!.isProd!));
        response.data = baseResponse.toJson();
        return response;
      }

      Options? options;

      // log.d('isRetailasdfasdfs: ${currentApiUrl?.getIsWeb} ,,,,, ${currentApiUrl?.retail} ,,,,, ${currentApiUrl?.appId}');
      response = await client!
          .post<dynamic>(operCode, data: request.toJson(), options: options);

      ///200-level (Success) — Server completed the request as expected
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
//          log.d('http status 2xx');

        if (response.data == null || response.data == '') {
          response.data = BaseResponse.json(0, 'OK');

          /// app талд таймаут болсон гэж үзэх хугацааг reset хийх
          if (refreshSessionTimeOut != null) {
            refreshSessionTimeOut!();
          }
        } else {
          baseResponse = BaseResponse.fromJson(response.data);

          /// handle response
          if (operCode != ApiOper.logout) {
            switch (baseResponse.responseCode) {
              /// Холболт салсан байна | Session timeout
              case BaseResponse.lostConnection:
                log.d(' LoggedOutByReason() CALLED-2 f: $sessionExpireMethod');
                //app.bloc.authBloc?.add(LoggedOutByReason(msg: baseResponse?.responseDesc));
                if (sessionExpireMethod != null) {
                  log.d(
                      ' LoggedOutByReason() CALLED-2.1 f: $sessionExpireMethod');
                  sessionExpireMethod!(baseResponse.responseDesc);
                }
                break;
              default:

                /// app талд таймаут болсон гэж үзэх хугацааг reset хийх
                if (refreshSessionTimeOut != null) {
                  refreshSessionTimeOut!();
                }
                break;
            }
          }
        }
      }

      ///400-level (Client error) — Client sent an invalid request
      else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        if (response.data == null || response.data == '') {
          response.data = BaseResponse.json(
              response.statusCode!,
              getErrMsg(cERR_904,
                  detail: response.statusMessage,
                  showDetail: !currentApiUrl!.isProd!));
        }
      }

      ///500-level (Server error) — Server failed to fulfill a valid request due to an error with server
      else if (response.statusCode! >= 500 && response.statusCode! < 600) {
        if (response.data == null || response.data == '') {
          response.data = BaseResponse.json(
              response.statusCode!,
              getErrMsg(cERR_905,
                  detail: response.statusMessage,
                  showDetail: !currentApiUrl!.isProd!));
        }
      }

      ///00-level (Informational) — Server acknowledges a request
      ///300-level (Redirection) — Client needs to perform further actions to complete the request
      ///other
      else {
        if (response.data == null || response.data == '') {
          response.data = BaseResponse.json(
              response.statusCode!,
              getErrMsg(cERR_901,
                  detail: response.statusMessage,
                  showDetail: !currentApiUrl!.isProd!));
        }
      }
    } on DioException catch (error) {
      log.wtf(
          'DioError Exception: $error, status: ${error.response?.statusCode}, response: ${error.response}',
          error: error);

      if (error.response != null) {
        switch (error.response?.statusCode) {
          case NetworkResultCode.cNetwork404:
            response.data = BaseResponse.json(
                cERR_904,
                getErrMsg(cERR_904,
                    detail: error.message,
                    showDetail: !currentApiUrl!.isProd!));
            break;
          default:
            response.data = BaseResponse.json(
                cERR_906,
                getErrMsg(cERR_906,
                    detail: error.message,
                    showDetail: !currentApiUrl!.isProd!));
            break;
        }
      } else {
        response.data = BaseResponse.json(
            cERR_907,
            getErrMsg(cERR_907,
                detail: error.message, showDetail: !currentApiUrl!.isProd!));
      }

      if (error.type == DioExceptionType.connectionTimeout) {
        response
          ..statusCode = NetworkResultCode.cNetworkTimeout
          ..data = BaseResponse.json(
              cERR_908,
              getErrMsg(cERR_908,
                  detail: error.message, showDetail: !currentApiUrl!.isProd!));
      }

      // try {
      //   _crashlyticRecordError(error, StackTrace.fromString(''), context: operCode);
      // } catch (_) {
      //   log.wtf('Crashlytics Exception: $_');
      // }
    } catch (error, stacktrace) {
      log.wtf('Exception occured', error: error, stackTrace: stacktrace);
      response.data = BaseResponse.json(
          cERR_909,
          getErrMsg(cERR_909,
              detail: '${Func.toStr(error)} ${Func.toStr(stacktrace)}',
              showDetail: !currentApiUrl!.isProd!));

      // try {
      //   _crashlyticRecordError(error, stacktrace, context: operCode);
      // } catch (_) {
      //   log.wtf('Crashlytics Exception: $_');
      // }
    } finally {
      // FileLog().writeLog('request: $operCode?app_id=${currentApiUrl?.appId}&app_secret=${currentApiUrl?.appSecret}&lang=$langId, \n data: ${(request.toJson())},');
      // FileLog().writeLog('response $response');
    }

    return response;
  }

  void _connectionChanged(dynamic hasConnection) async {
    log.d(
        '$runtimeType _connectionChanged() CALLED [${currentApiUrl?.baseUrl}] hasConnection: $hasConnection networkConnectionChanged: $networkConnectionChanged');
    isOffline = (hasConnection is bool) ? !hasConnection : true;
    if (networkConnectionChanged != null) {
      await networkConnectionChanged!();
    }
  }

// void _crashlyticRecordError(dynamic exception, StackTrace stack, {dynamic context}) async {
//   // await Crashlytics.instance.recordError(exception, stack, context: context);
//   await FirebaseCrashlytics.instance.recordError(exception, stack, reason: context);
// }

  ///
  /// regular base url get
  ///
  Future<Response> get(String operCode,
      {BaseRequest? request, bool validateExpired = true}) async {
    var response = Response<dynamic>(requestOptions: RequestOptions(path: ''));
    // assert(request != null);
    var baseResponse = BaseResponse(responseCode: 0);
    //logger.func = 'post';
    try {
      if (isOffline) {
        response.statusCode = 400;
        baseResponse = BaseResponse(
            responseCode: cERR_911,
            responseDesc:
                getErrMsg(cERR_911, showDetail: !currentApiUrl!.isProd!));
        response.data = baseResponse.toJson();
        return response;
      }

      Options? options;
      if (!Func.isNullEmpty(sessionId) && !kIsWeb) {
        options = Options(
            headers: <String, String>{'Cookie': 'ACCESS_TOKEN=$sessionId'});
      }

      if (request != null) {
        // response = await _clientBase.get<dynamic>(path, queryParameters: params);
        response = await _clientBase!.get<dynamic>(operCode, options: options);
      } else {
        // response = await _clientBase.get(path);
        response = await _clientBase!.get<dynamic>(operCode, options: options);
      }

      ///200-level (Success) — Server completed the request as expected
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (response.data == null || response.data == '') {
          response.data = BaseResponse.json(0, 'OK');

          /// app талд таймаут болсон гэж үзэх хугацааг reset хийх
          if (refreshSessionTimeOut != null) {
            refreshSessionTimeOut!();
          }
        } else {
          baseResponse = BaseResponse.fromJson(response.data);

          switch (baseResponse.responseCode) {
            /// Холболт салсан байна | Session timeout
            case BaseResponse.lostConnection:
              log.d(' LoggedOutByReason() CALLED-2 f: $sessionExpireMethod');
              //app.bloc.authBloc?.add(LoggedOutByReason(msg: baseResponse?.responseDesc));
              if (sessionExpireMethod != null) {
                log.d(
                    ' LoggedOutByReason() CALLED-2.1 f: $sessionExpireMethod');
                sessionExpireMethod!(baseResponse.responseDesc);
              }
              break;
            default:

              /// app талд таймаут болсон гэж үзэх хугацааг reset хийх
              if (refreshSessionTimeOut != null) {
                refreshSessionTimeOut!();
              }
              break;
          }
        }
      }

      ///400-level (Client error) — Client sent an invalid request
      else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        if (response.data == null || response.data == '') {
          response.data = BaseResponse.json(
              response.statusCode!,
              getErrMsg(cERR_904,
                  detail: response.statusMessage,
                  showDetail: !currentApiUrl!.isProd!));
        }
      }

      ///500-level (Server error) — Server failed to fulfill a valid request due to an error with server
      else if (response.statusCode! >= 500 && response.statusCode! < 600) {
        if (response.data == null || response.data == '') {
          response.data = BaseResponse.json(
              response.statusCode!,
              getErrMsg(cERR_905,
                  detail: response.statusMessage,
                  showDetail: !currentApiUrl!.isProd!));
        }
      }

      ///00-level (Informational) — Server acknowledges a request
      ///300-level (Redirection) — Client needs to perform further actions to complete the request
      ///other
      else {
        if (response.data == null || response.data == '') {
          response.data = BaseResponse.json(
              response.statusCode!,
              getErrMsg(cERR_901,
                  detail: response.statusMessage,
                  showDetail: !currentApiUrl!.isProd!));
        }
      }
    } on DioException catch (error) {
      log.f(
          'DioError Exception: $error, status: ${error.response?.statusCode}, response: ${error.response}',
          error: error);

      if (error.response != null) {
        switch (error.response?.statusCode) {
          case NetworkResultCode.cNetwork404:
            response.data = BaseResponse.json(
                cERR_904,
                getErrMsg(cERR_904,
                    detail: error.message,
                    showDetail: !currentApiUrl!.isProd!));
            break;
          default:
            response.data = BaseResponse.json(
                cERR_906,
                getErrMsg(cERR_906,
                    detail: error.message,
                    showDetail: !currentApiUrl!.isProd!));
            break;
        }
      } else {
        response.data = BaseResponse.json(
            cERR_907,
            getErrMsg(cERR_907,
                detail: error.message, showDetail: !currentApiUrl!.isProd!));
      }

      if (error.type == DioExceptionType.connectionTimeout) {
        response
          ..statusCode = NetworkResultCode.cNetworkTimeout
          ..data = BaseResponse.json(
              cERR_908,
              getErrMsg(cERR_908,
                  detail: error.message, showDetail: !currentApiUrl!.isProd!));
      }

      if (error.type == DioExceptionType.receiveTimeout) {
        response
          ..statusCode = NetworkResultCode.cNetworkTimeout
          ..data = BaseResponse.json(
              cERR_903,
              getErrMsg(cERR_903,
                  detail: error.message, showDetail: !currentApiUrl!.isProd!));
      }

      if (error.type == DioExceptionType.sendTimeout) {
        response
          ..statusCode = NetworkResultCode.cNetworkTimeout
          ..data = BaseResponse.json(
              cERR_902,
              getErrMsg(cERR_902,
                  detail: error.message, showDetail: !currentApiUrl!.isProd!));
      }
    } catch (error, stacktrace) {
      log.wtf('Exception occured', error: error, stackTrace: stacktrace);
      response.data = BaseResponse.json(
          cERR_909,
          getErrMsg(cERR_909,
              detail: Func.toStr(error), showDetail: !currentApiUrl!.isProd!));
    }

    return response;
  }

  ///
  /// regular base url post
  ///
  Future<Response> post(String operCode, BaseRequest request) async {
    return _post(_clientBase, operCode, request);
  }

  ///
  /// regular base url post (Long connection time out)
  ///
  Future<Response> conTimeOutLongPost(
      String operCode, BaseRequest request) async {
    _clientBase!.options.connectTimeout = Duration(seconds: conTimeOutLongest);
    return _post(_clientBase, operCode, request);
  }

  ///
  ///connection_error
  ///
  static const cERR_901 = 901;
  static const cERR_902 = 902;
  static const cERR_903 = 903;
  static const cERR_904 = 904;
  static const cERR_905 = 905;
  static const cERR_906 = 906;
  static const cERR_907 = 907;
  static const cERR_908 = 908;
  static const cERR_909 = 909;

  ///exec_timeout
  static const cERR_910 = 910;

  ///check_internet
  static const cERR_911 = 911;

  static const cERR_Default = 999;

  ///
  String getErrMsg(int errCode, {bool showDetail = true, String? detail}) {
    var msg = 'Error $errCode';
    switch (errCode) {
      case cERR_901:
      case cERR_902:
      case cERR_903:
      case cERR_905:
      case cERR_906:
      case cERR_907:
      case cERR_908:
        msg =
            '${showDetail ? '$errCode. ' : ''}${msgConnectionError ?? 'Failed to perform action! Connection error'} ${showDetail && detail != null ? '[$detail]' : ''}';
        break;
      case cERR_904:
        msg =
            '${showDetail ? '$errCode. ' : ''}${msgServiceUnavailable ?? 'Failed to perform action! Service unavailable'} ${showDetail && detail != null ? '[$detail]' : ''}';
        break;
      case cERR_909:
        msg =
            '${showDetail ? '$errCode. ' : ''}${msgConnectionError ?? 'Unknown response!'} ${showDetail && detail != null ? '[$detail]' : ''}';
        break;
      case cERR_910:
        msg =
            '${showDetail ? '$errCode. ' : ''}${msgExecTimeout ?? 'Failed to perform action! Timeout'} ${showDetail && detail != null ? '[$detail]' : ''}';
        break;
      case cERR_911:
        msg =
            '${showDetail ? '$errCode. ' : ''}${msgCheckInternet ?? 'Please check internet connection!'} ${showDetail && detail != null ? '[$detail]' : ''}';
        break;
      default:
        msg = 'Internal error';
        break;
    }
    return msg;
  }

  static bool isNetworkError(int responseCode) {
    switch (responseCode) {
      case cERR_901:
      case cERR_902:
      case cERR_903:
      case cERR_904:
      case cERR_905:
      case cERR_906:
      case cERR_907:
      case cERR_908:
      case cERR_909:
      case cERR_910:
      case cERR_911:
        return true;
    }
    return false;
  }
}

///
/// NetworkResultCode
///
class NetworkResultCode {
  ///Network Error
  static const cNetworkError = -1;

  ///network timeout
  static const cNetworkTimeout = -2;

  ///network timeout
  static const cNetwork404 = 404;

  ///Network returns data formatted once
  static const cNetworkJsonException = -3;

  static const cSuccess = 200;
}
