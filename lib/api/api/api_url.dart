enum UrlOption {
  prod,
  prodReview,
  dev,
}

class ApiUrl {
  ///
  /// internal
  ///
  final UrlOption? option;
  final String? desc;

  final String baseUrl;

  final bool? isProd;
  final String? testUserLoginCode;

  var apiUrls = <ApiUrl>{};
  var apiUrlMap = <UrlOption?, ApiUrl>{};

  ApiUrl({
    this.option,
    this.desc,
    this.baseUrl = '',
    this.isProd,
    this.testUserLoginCode,
  });

  @override
  String toString() => '''ApiUrl{
  option: $option,
  desc: $desc,
  baseUrl: $baseUrl,
  isProd: $isProd,
  testUserLoginCode: $testUserLoginCode,
  
  }''';

  addAll(List<ApiUrl>? pApiUrls) {
    if (pApiUrls == null) return;
    apiUrls.addAll(pApiUrls);
    for (var el in pApiUrls) {
      apiUrlMap.putIfAbsent(el.option, () => el);
    }
  }

  add(ApiUrl apiUrl) {
    apiUrls.add(apiUrl);
    apiUrlMap.putIfAbsent(apiUrl.option, () => apiUrl);
  }

  ApiUrl? item(UrlOption op) {
    if (apiUrlMap.containsKey(op)) {
      return apiUrlMap[op];
    } else {
      return null;
    }
  }

  ApiUrl? itemAt(int index) {
    if (index > -1 && index < apiUrls.length) {
      return apiUrls.elementAt(index);
    } else {
      return null;
    }
  }

  void remove(UrlOption op) {
    var obj = apiUrlMap[op];
    if (obj != null) {
      apiUrls.remove(obj);
      apiUrlMap.remove(op);
    }
  }

  void removeAt(int index) {
    ApiUrl obj;
    if (index > -1 && index < apiUrls.length) {
      obj = apiUrls.elementAt(index);
      apiUrls.remove(obj);
      apiUrlMap.remove(obj.option);
    }
  }

  void clear() {
    apiUrlMap.clear();
    apiUrls.clear();
  }

  int count() {
    return apiUrls.length;
  }
}
