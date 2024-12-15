import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'validators.dart';

class Func {
  // static //final logger = Logger('Utils');

//  static String baseId;

  // Generate a v1 (time-based) id
//  uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'

// Generate a v4 (random) id
//  uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

// Generate a v5 (namespace-name-sha1-based) id
//  uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com'); // -> 'c74a196f-f19d-5ea9-bffd-a2742432fc9c'

//  static() {
//    // //logger.func = "static";
//    // log.d(s: 1);
//  }

  static String uuid() {
    return const Uuid().v1();
  }

  static String nextTrace() {
    // //logger.func = "nextTrace";

    var now = DateTime.now();
    var formatter = DateFormat('yyyyMMddHHmmss');
    String trace = "${formatter.format(now)}00";

    // log.d(s: 1, m: "TRACENO: $trace, len:${trace.length.toString()}");
    return trace;
  }

  static bool isEmpty(Object? o) => isNullEmpty(o);

  static String strEmpty2Dot(Object? o) =>
      isNullEmpty(o) ? '...' : Func.toStr(o);

  static bool isNotEmpty(Object? o) => isNotNullEmpty(o);

  static bool isNullEmpty(Object? o) => o == null || "" == o;

  static bool isListNullOrEmpty(List<Object?>? o) => o == null || o.isEmpty;

  static bool isListNotNullOrEmpty(List<Object?>? o) => !isListNullOrEmpty(o);

  static bool isNotNullEmpty(Object? o) => o != null && o != '';

  static bool isNotNullEmptyAndSpace(String? str) =>
      str != null && str != '' && str != ' ';

  static bool isNullEmptyOrFalse(Object? o) =>
      o == null || false == o || "" == o;

  static bool isNullEmptyFalseOrZero(Object? o) =>
      o == null || false == o || 0 == o || "" == o;

  static int toInt2(Object? o) {
    if (isNullEmpty(o)) {
      return 0;
    }
    return int.parse(o.toString());
  }

  static int toInt(Object? o) =>
      isNullEmpty(o) ? 0 : Func.toDouble(o.toString()).toInt();

  static bool toBoolFromObj(Object? o) =>
      toBool(isNullEmpty(o) ? 0 : int.parse(o.toString()));

  static bool toBool(int i) => (i == 1);

  static bool toBoolSafe(bool? b) => b ?? false;

  static bool toBoolFromStr(String? s) => isNullEmpty(s)
      ? false
      : s!.toUpperCase() == "TRUE"
          ? true
          : false;

  static String toStr(Object? o) => isNullEmpty(o) ? "" : o.toString();

  static String toUpperCase(String? str) {
    return Func.toStr(str).toUpperCase();
  }

  static String? capitalizeFirstLetter(String? str) {
    str = Func.toStr(str);

    if (str.isEmpty) {
      return str;
    } else if (str.length == 1) {
      return str.toUpperCase();
    } else {
      return '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}';
    }
  }

  static String getIntegerFromDouble(Object? o) {
    var s = Func.toStr(o);
    var a = s.split('.');
    if (a.isNotEmpty) {
      return a[0];
    } else {
      return '';
    }
  }

  /// if o == xxx.0 then return '' for textFractionTextBox
  static String getFractionFromDouble(Object? o) {
    var round = (Func.toMoneyStr(
        (((Func.toDouble(Func.toMoneyStr(o,
                            numberFormat: NumberFormat("#,###.000"))
                        .replaceAll(',', "")) *
                    100)
                .roundToDouble()) /
            100),
        numberFormat: NumberFormat("#,###.00")));
    // print('-------------------------------$round');

    var s = Func.toStr(round);
    var a = s.split('.');
    if (a.length > 1) {
      return Func.toInt(a[1]) == 0 ? '' : a[1]; //'00' гэж буцаахгүй байх !!!
    } else {
      return ''; //'00' гэж буцаахгүй байх !!!
    }
  }

  static double roundToDecimals(num numToRound, num deciPlaces) {
    num modPlus1 = pow(10, deciPlaces + 1);
    String strMP1 = ((numToRound * modPlus1).roundToDouble() / modPlus1)
        .toStringAsFixed(Func.toInt(deciPlaces) + 1);
    int lastDigitStrMP1 = int.parse(strMP1.substring(strMP1.length - 1));

    num mod = pow(10, deciPlaces);
    String strDblValRound = ((numToRound * mod).roundToDouble() / mod)
        .toStringAsFixed(Func.toInt(deciPlaces));
    int lastDigitStrDVR =
        int.parse(strDblValRound.substring(strDblValRound.length - 1));

    return (lastDigitStrMP1 == 5 && lastDigitStrDVR % 2 != 0)
        ? ((numToRound * mod).truncateToDouble() / mod)
        : double.parse(strDblValRound);
  }

  static double toDouble(Object? objDouble,
      {String thousandSeparator = ",",
      String rightSymbol = "",
      String leftSymbol = ""}) {
    double val = 0;

    var strDouble = Func.toStr(objDouble);

    strDouble = (strDouble.isEmpty) ? '0' : strDouble;

    strDouble = strDouble
        .replaceAll(thousandSeparator, '')
        .replaceAll(rightSymbol, '')
        .replaceAll(leftSymbol, '');

    try {
      val = double.parse(strDouble);
    } catch (_) {
      val = 0;
    }
    return val;
  }

  static bool isDigit(String? value) {
    ///Зөвхөн тоо агуулсан эсэхийг шалгана

    RegExp isDegit = RegExp(
      // r'\\d+',
      r'^[0-9]+$',
    );

    try {
//      String regex = "\\d+";

      if (value == null) {
        return false;
      }

      if (value.trim().isEmpty) {
        return false;
      }

      if (!isDegit.hasMatch(value)) {
        return false;
      }
    } catch (_) {
      //App.error(e);
      return false;
    }

    return true;
  }

  static bool isMatchPinPolisy(String value, String charValue) {
    ///Оруулсан нууц үгэнд зөвхөн Pinpolicy -гоос ирсэн charValue байгаа эсэхийг шалгана.
    if (isNullEmpty(charValue) || isNullEmpty(value)) {
      return true;
    }
    final split = value.split('');
    for (var i in split) {
      if (!charValue.contains(i)) {
        return false;
      }
    }
    return true;
  }

  String isMatchPinPolisyAndReturn(String value, String charValue) {
    ///Оруулсан нууц үгэнд зөвхөн Pinpolicy -гоос ирсэн charValue байгаа эсэхийг шалгаад байхгүй тэмдэгтийг буцаана.
    if (isNullEmpty(charValue) || isNullEmpty(value)) {
      return '';
    }
    Set<String> restricted = {};
    final split = value.split('');
    for (var i in split) {
      if (!charValue.contains(i)) {
        restricted.add(i);
      }
    }

    if (restricted.isEmpty) {
      return '';
    } else {
      return restricted.join("");
    }
  }

  static bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  static String toMoneyStrNoneZeroFraction(
    Object? value, {
    bool secureMode = false,
    NumberFormat? numberFormat,
    String? suffix,
    String? prefix,
    bool space = false,
    String? secureValue,
  }) {
    var result = secureValue ?? '*,***.**';
    if (!secureMode) {
      try {
        value ??= 0.0;
        double tmpDouble = double.parse(Func.toStr(value).replaceAll(",", ""));

        String doubleAsString = tmpDouble.toString();
        int indexOfDecimal = doubleAsString.indexOf('.');
        NumberFormat formatter = numberFormat ?? NumberFormat("#,##0.00");

        if (Func.toInt(doubleAsString.substring(indexOfDecimal + 1)) == 0) {
          formatter = numberFormat ?? NumberFormat("#,###");
        }

        result = formatter.format(tmpDouble);
        //print("result: $result");
        // if (!result.contains('.')) {
        //   result += '.00';
        // }
      } catch (e) {
        // print("*******  Алдаа  ***********");
        // print("Функц: Func.toMoneyStr()");
        // print("Утга: $value");
        // print(e);
        result = "0.00";
      }
    }

    var space0 = space ? ' ' : '';
    prefix = prefix == null ? '' : '$prefix$space0';
    suffix = suffix == null ? '' : '$space0$suffix';

    return '$prefix$result$suffix';
  }

  static String toMoneyStrWithCurCode(
    Object? value,
    String? curCode, {
    bool secureMode = false,
    NumberFormat? numberFormat,
    bool isPrefix = true,
    String? suffix,
    bool space = false,
    String? secureValue,
  }) {
    var symbol = toCurSymbol(curCode);
    return Func.toMoneyStr(
      value,
      secureMode: secureMode,
      numberFormat: numberFormat,
      prefix: isPrefix ? symbol : suffix,
      suffix: isPrefix ? suffix : symbol,
      space: space,
      secureValue: secureValue,
    );
  }

  static String toMoneyStr(
    Object? value, {
    bool secureMode = false,
    NumberFormat? numberFormat,
    String? suffix,
    String? prefix,
    bool space = false,
    String? secureValue,
  }) {
    /// Format number with "Decimal Point" digit grouping.
    /// 10000 -> 10,000.00 or 10,000
    /// 10000.22 -> 10,000.22

    var result = secureValue ?? '*,***.**';
    if (!secureMode) {
      try {
        value ??= 0.0;
        double tmpDouble = double.parse(Func.toStr(value).replaceAll(",", ""));
        NumberFormat formatter = numberFormat ?? NumberFormat("#,##0.00");
        result = formatter.format(tmpDouble);
        //print("result: $result");
        // if (!result.contains('.')) {
        //   result += '.00';
        // }
      } catch (e) {
        // print("*******  Алдаа  ***********");
        // print("Функц: Func.toMoneyStr()");
        // print("Утга: $value");
        // print(e);
        result = "0.00";
      }
    }

    var space0 = space ? ' ' : '';
    prefix = prefix == null ? '' : '$prefix$space0';
    suffix = suffix == null ? '' : '$space0$suffix';

    return '$prefix$result$suffix';
  }

  static String toIntegerMoneyStr(
    Object value, {
    bool? secureMode, //Secure mode ашиглах эсэх
    NumberFormat? numberFormat,
  }) {
    /// Format number with "Decimal Point" digit grouping.
    /// 10000 -> 10,000

    //Secure mode ашиглах бол дансны үлдэгдлийг нуух эсэх
//    if (isTest) return "***";

//    if ((secureMode ?? false) && app.user.secureMode) return "***";

    //Хоосон утгатай эсэх
    if (Func.toStr(value) == "") {
      return "0";
    }

    //Зөвхөн тоо агуулсан эсэх
    String tmpStr = Func.toStr(value).replaceAll(",", "").replaceAll(".", "");
    if (!isNumeric(tmpStr)) {
      return "0";
    }

    //Хэрэв ',' тэмдэгт агуулсан бол устгана
    double tmpDouble = double.parse(Func.toStr(value).replaceAll(",", ""));

    String result = "";
    try {
      //Format number
//      final formatter = new NumberFormat("#,###.##", "pt-br");
      NumberFormat formatter = numberFormat ?? NumberFormat("#,###,###");
      result = formatter.format(tmpDouble);
    } catch (e) {
      // print("*******  Алдаа  ***********");
      // print("Функц: Func.toIntegerMoneyStr()");
      // print("Утга: " + tmpDouble.toString());
      // print(e);
      result = "0";
    }

    return result;
  }

  static double toRound(double val) {
    return Func.toDouble(Func.toMoneyStr(
        (((Func.toDouble(Func.toMoneyStr(val,
                            numberFormat: NumberFormat("#,###.000"))
                        .replaceAll(',', "")) *
                    100)
                .roundToDouble()) /
            100),
        numberFormat: NumberFormat("#,###.00")));
  }

  static String fractionStr(double? number) {
    // Тооны бутархай хэсгийг салгаад, 2 орноор тасалж буцаана
    // Input: 123.456
    // Output: '45'

    String result;
    if (number == null) return "";
    if (number.toInt() == number) return "00";

    result = number.toString().split('.')[1];
    if (result.length == 1) {
      result += "0";
    } else {
      result = result.substring(0, 2);
    }

    return result;
  }

  static String toCurSymbol(String? curCode) {
    String currencySymbol;

    switch (Func.toStr(curCode)) {
      case "MNT":
        currencySymbol = "₮";
        break;

      case "EUR":
        currencySymbol = "€";
        break;

      case "USD":
        currencySymbol = "\$";
        break;

      case "CNY":
        currencySymbol = "¥";
        break;

      case "RUB":
        currencySymbol = "₽";
        break;

      case "ACO":
        currencySymbol = "ACO";
        break;

      case "RDX":
        currencySymbol = "RDX";
        break;

      default:
        currencySymbol = curCode ?? '';
        break;
    }

    return currencySymbol;
  }

  /// үүнийг өөр тийш нь зөөх бизнес хэсэгрүү
//  static Account getAccountByCode(String acntCode) {
//    /// Дансны жагсаалтаас дугаараар нь данс хайж, утгыг буцаана
//    Account account;
//    for (Account el in app.accountList) {
//      if (el.acntCode == acntCode) {
//        account = el;
//        break;
//      }
//    }
//
//    return account;
//  }

  /// үүнийг өөр тийш нь зөөх бизнес хэсэгрүү
//  static int getAccountIndexByCode(String acntCode) {
//    /// Дансны жагсаалтаас дугаараар нь индексыг хайж, утгыг буцаана
//    int index = 0;
//    for (int i = 0; i < app.accountList.length; i++) {
//      if (app.accountList[i].acntCode == acntCode) {
//        index = i;
//        break;
//      }
//    }
//
//    return index;
//  }

  static String trim(String str) {
    // Бүх whitespace-ийг устгана
    if (isNullEmpty(str)) return "";

    return str.replaceAll(RegExp(r"\s+\b|\b\s"), "");
  }

  static String toAcntNo(String? str) {
    // ### ### ### formatand oruulna
    if (isNullEmpty(str)) return "";
    String formatted = "";
    int start = 0;

    if (Func.toInt(str!.length) % 4 != 0) {
      for (var i = 0; i < (str.length / 3).round(); i++) {
        if (i < (str.length / 3).round() - 1) {
          formatted += " ${str.substring(start, start + 3)}";
          start += 3;
        } else {
          formatted += " ${str.substring(start, str.length)}";
        }
      }
    } else {
      for (var i = 0; i < (str.length / 4).round(); i++) {
        if (i < (str.length / 4).round() - 1) {
          formatted += "${str.substring(start, start + 4)} ";
          start += 4;
        } else {
          formatted += "${str.substring(start, str.length)} ";
        }
      }
    }

    return formatted;
  }

  static bool validateVatRegNo(String? regno) {
    //НӨАТ төлөгчийн дугаар
    if (isNullEmpty(regno)) return false;
    String pattern = r"(^\d{7,12}|[а-яА-ЯёЁөӨүҮ]{2}\d{8}$)";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(regno!.toUpperCase());
  }

  static bool checkMobileNumber(String mobile) {
    String pattern = r'(^\d{8}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(mobile);
  }

  ///
  /// yyyy-MM-dd'T'HH:mm:ss.SSS'Z'  String -> DateTime
  ///
  static DateTime toDateTimeFromStr(String? str, {DateTime? defaultDt}) {
    if (isEmpty(str)) return defaultDt ?? DateTime.now();
    try {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(str!);
    } catch (_) {
      return defaultDt ?? DateTime.now();
    }
  }

  ///
  /// yyyy-MM-dd HH:mm:ss.SSS -> yyyy-MM-dd'T'HH:mm:ss.SSS
  ///
  static String toDateTimeZoneStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01T15:13:00.000'
    if (isEmpty(str)) return '';
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(DateTime.parse(str!));
  }

  static String toDateTimeZoneStrFromDateTime(DateTime dt) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dt);
  }

  static String toDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01T15:13:00.000' to '2019.01.01 15:13:00'
    if (isEmpty(str)) return '';
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(str!));
    } catch (_) {
      return str ?? '';
    }
  }

  static String toDateDotStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019-01-01T15:13:00.000' to '2019.01.01'
    if (isEmpty(str)) return '';
    try {
      return DateFormat('yyyy.MM.dd').format(DateTime.parse(str!));
    } catch (_) {
      return str ?? '';
    }
  }

  static String toDateTimeStrLong2(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019-01-01 15:13:00' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .format(DateTime.parse(str!));
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  ///
  ///  yyyy-MM-dd'T'HH:mm:ss.SSS'Z' -> yyyy.MM
  ///
  static String toYYYYMMFromDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';
    String formattedDate = DateFormat("yyyy.MM")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(str!));
    return formattedDate;
  }

  static String toYYYYMMFromDefDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';
    String formattedDate = DateFormat("yyyy.MM").format(DateTime.parse(str!));
    return formattedDate;
  }

  ///
  ///  yyyy-MM-dd'T'HH:mm:ss.SSS'Z' -> yyyy.MM.dd
  ///
  static String toYYYYMMDDFromDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("yyyy.MM.dd")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(str!));
    return formattedDate;
  }

  ///
  ///  yyyy-MM-dd'T'HH:mm:ss.SSS'Z' -> yyyy.MM.dd HH.mm.ss
  ///
  static String toYYYYMMDDhhmmssFromDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("yyyy.MM.dd HH:mm:ss")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(str!));

    return formattedDate;
  }

  ///
  /// datetime -> yyyy.MM.dd string
  ///
  // static String toDateParseStr(String str) {
  //   // Datetime string-ийг форматлаад буцаана '2019.01.01T15:13:00.000'
  //   if (isEmpty(str)) return '';
  //
  //   DateTime dateTime = DateTime.parse(str);
  //   String formattedDate = DateFormat("yyyy.MM.dd").format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dateTime)));
  //   return formattedDate; //trim(str.split(" ")[0]);
  // }
  static String toDateStrFromDate(DateTime dt) {
    return DateFormat("yyyy.MM.dd").format(dt);
  }

  static String toYearStrFromDate(DateTime dt) {
    return DateFormat("yyyy").format(dt);
  }

  static String getDateStr(String? str) {
    /// Datetime string-ээс date string-ийг буцаана
    /// '2019.01.01 15:13:00' to '2019.01.01'
    /// '2019.01.01T15:13:00' to '2019.01.01'
    if (isNullEmpty(str)) return '';
    if (str!.contains('T')) return trim(str.split('T')[0]);
    if (str.contains(' ')) return trim(str.split(' ')[0]);
    return str;
  }

  ///
  ///  yyyy-MM-dd'T'HH:mm:ss.SSS'Z' -> MM/dd
  ///
  static String toMMddFromDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate =
        DateFormat("MM/dd").format(DateFormat("yyyy.MM.dd").parse(str!));
    return formattedDate;
  }

  ///
  ///  yyyy-MM-dd'T'HH:mm:ss.SSS'Z' -> yyyy
  ///
  static String toYYYYFromDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("MM")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(str!));
    return formattedDate;
  }

  ///
  ///  yyyy-MM-dd'T'HH:mm:ss.SSS'Z' -> MM
  ///
  static String toMMFromDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("MM")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(str!));
    return formattedDate;
  }

  static String toMMFromDefDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("MM").format(DateTime.parse(str!));
    return formattedDate;
  }

  ///
  ///  yyyy-MM-dd'T'HH:mm:ss.SSS'Z' -> dd
  ///
  static String toDDFromDateTimeStr(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("dd")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(str!));
    return formattedDate;
  }

  ///
  ///  yyyy.MM.dd -> yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
  ///
  static String toDateTimeStrFromDate(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .format(DateFormat("yyyy.MM.dd").parse(str!));
    return formattedDate;
  }

  ///
  /// yyyy.MM.dd HH:mm:ss -> yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
  ///
  static String toDateTimeStrFromDateTime(String str) {
    // Datetime string-ийг форматлаад буцаана '2019.01.01 15:13:00' to '2019-01-01T15:13:00.000'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .format(DateFormat("yyyy.MM.dd HH:mm:ss").parse(str));
    return formattedDate;
  }

  ///
  /// yyyy-MM-dd'T'HH:mm:ss.SSS'Z' ->  yyyy.MM.dd HH:mm:ss
  ///
  static String toDateTimeStrFromDateTimeReverse(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019-01-01T15:13:00.000' to '2019.01.01 15:13:00'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("yyyy.MM.dd HH:mm:ss")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(str!));
    return formattedDate;
  }

  ///
  /// yyyy-MM-dd'T'HH:mm:ss.SSS' ->  yyyy.MM.dd HH:mm:ss
  ///
  static String toDateTimeStrFromDateTimeReverseWithoutZ(String? str) {
    // Datetime string-ийг форматлаад буцаана '2019-01-01T15:13:00.000' to '2019.01.01 15:13:00'
    if (isEmpty(str)) return '';

    String formattedDate = DateFormat("yyyy.MM.dd HH:mm:ss")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(str!));
    return formattedDate;
  }

  static String toDateStr(String? str) {
    // Datetime string-ээс date string-ийг буцаана '2019.01.01T15:13:00.000' to '2019.01.01'
    if (isEmpty(str)) return '';

    DateTime dateTime = DateTime.parse(str!);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

    return formattedDate.split(' ')[0];
  }

  static int dateTimeDiffFromNow(String str) {
    if (isEmpty(str)) return 0;
    int leftDate = 0;
    DateTime now = DateTime.now();
    DateTime el = DateTime.parse(Func.toDateTimeZoneStr(str));

    leftDate = el.difference(now).inDays;
    return leftDate;
  }

  static int dateTimeDifferentFromNow(String str) {
    if (isEmpty(str)) return 0;
    int leftDate = 0;
    DateTime now = DateTime.now();
    DateTime el = DateTime.parse(Func.toDateTimeZoneStr(str));

    leftDate = now.difference(el).inDays;
    return leftDate;
  }

  static int dateTimeDifferentFromStart(String? str, String? startStr) {
    if (isEmpty(str)) return 0;
    if (isEmpty(startStr)) return 0;
    int leftDate = 0;
    DateTime end = DateTime.parse(Func.toDateTimeZoneStr(str));
    DateTime start = DateTime.parse(Func.toDateTimeZoneStr(startStr));

    leftDate = end.difference(start).inDays;
    return leftDate;
  }

  static String toMonthDayStr(String? str) {
    // Datetime string-ээс date string-ийг буцаана '2019.01.01T15:13:00.000' to '2019.01.01'
    if (isEmpty(str)) return '';

    DateTime dateTime = DateTime.parse(str!);
    String formattedDate = DateFormat('MM-dd HH:mm:ss').format(dateTime);

    return formattedDate.split(' ')[0];
  }

  static String toTimeStr(String? str) {
    // Datetime string-ээс time string-ийг буцаана '2019.01.01T15:13:00.000' to '15:13:00'
    if (isEmpty(str)) return '';

    DateTime dateTime = DateTime.parse(str!);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

    return formattedDate.split(' ')[1];
  }

  static String toTimeStrNotSec(String? str) {
    // Datetime string-ээс time string-ийг буцаана '2019.01.01T15:13:00.000' to '15:13:00'
    if (isEmpty(str)) return '';

    DateTime dateTime = DateTime.parse(str!);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

    return formattedDate.split(' ')[1];
  }

  static String utcToTimeStrNotSec(String? str) {
    // Datetime string-ээс time string-ийг буцаана '2019.01.01T15:13:00.000' to '15:13:00'

    if (isEmpty(str)) return '';
    DateTime dateTime = DateTime.parse("${str!}z");

    // var dateTime = DateFormat("dd-MM-yyyy HH:mm:ss").parse(str!);
    var dateLocal = dateTime.toUtc().toLocal();
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm").format(dateLocal);

    return formattedDate.split(' ')[1];
  }

//  static String getDateStr(String str) {
//    // Datetime string-ээс date string-ийг буцаана '2019.01.01 15:13:00' to '2019.01.01'
//    if (isNullEmpty(str)) return "";
//    if (!str.contains(" ")) return str;
//
//    return trim(str.split(" ")[0]);
//  }

//  static String getTimeStr(String str) {
//    // Datetime string-ээс time string-ийг буцаана '2019.01.01 15:13:00' to '15:13:00'
//    if (isNullEmpty(str)) return "";
//    if (!str.contains(" ")) return str;
//
//    return str.split(" ")[1];
//  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static List<T> map<T>({required List list, required Function listItem}) {
    // list ашиглан шинэ list үүсгэх. Жишээ нь: List<T>-ээс List<Widget> үүсгэх.
    var newList = <T>[];
    for (var i = 0; i < list.length; i++) {
      newList.add(listItem(i));
    }
    return newList;
  }

  static Color toColor(String? hexString) {
    // String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
    if (isNullEmpty(hexString)) hexString = '#0674d5';
    final buffer = StringBuffer();
    if (hexString?.length == 6 || hexString?.length == 7) buffer.write('ff');
    buffer.write(hexString?.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static bool isValidUrl(String url) {
    return Uri.parse(toStr(url)).isAbsolute;
  }

  static String maskMobile(String str, int len) {
    str = Func.toStr(str);
    if (str.length > 3) {
      return str.substring(0, 3).padRight(len, maskChar);
    }
    return str;
  }

  static String maskString(String str) {
    var maskedString = '';

    for (int i = 0; i < str.length; i++) {
      if (i % 3 == 0 || str[i] == ' ' || str[i] == '.' || str[i] == '-') {
        maskedString += str[i];
      } else {
        maskedString += maskChar;
      }
    }

    return maskedString;
  }

  static String tranMaskString(String str) {
    var maskedString = '';

    if (Func.isNullEmpty(str)) return maskedString;

    var str0 = str.split(' ');

    if (str0.length > 1) {
      maskedString += str0.first[0];
      for (var el = 1; el < str0[0].length; el++) {
        maskedString += maskChar;
      }

      maskedString += ' ';
      maskedString += str0[1];
    } else {
      maskedString = str;
    }

    // print('tranMaskString: ${maskedString}');
    return maskedString;
  }

  static String deviceIdMaskString(String str, {String chnlType = 'ANDROID'}) {
    var maskedString = '';
    var count = 0;

    if (Func.isNullEmpty(str)) return maskedString;

    for (int i = 0; i < str.length; i++) {
      if (i < 3 ||
          i > str.length - 4 ||
          str[i] == ' ' ||
          str[i] == '.' ||
          str[i] == '-') {
        maskedString += str[i];
        count += 1;
      } else {
        if ((i - count) % 4 == 0) {
          maskedString += str[i];
        } else {
          maskedString += maskChar;
        }
      }
    }

    // print('tranMaskString: ${maskedString}');
    return maskedString;
  }

  static String formMaskString(String str) {
    var maskedString = '';

    if (Func.isNullEmpty(str)) return maskedString;

    for (int i = 0; i < str.length; i++) {
      if (i % 2 == 1) {
        maskedString += maskChar;
      } else {
        maskedString += str[i];
      }
    }

    // print('tranMaskString: ${maskedString}');
    return maskedString;
  }

  static String nameMaskString(String str) {
    var maskedString = '';

    if (Func.isNullEmpty(str)) return maskedString;

    for (int i = 0; i < str.length; i++) {
      if (i < 5 || str[i] == ' ' || str[i] == '.' || str[i] == '-') {
        maskedString += str[i];
      } else {
        maskedString += maskChar;
      }
    }

    // print('tranMaskString: ${maskedString}');
    return maskedString;
  }

  /// double төрлийн таслалаас хойшхи хүссэн оронгоор авна
  static double roundDouble(double value, int places) {
    double mod = pow(10.0, places) as double;
    return ((value * mod).round().toDouble() / mod);
  }

  ///String format
  static String format(String format, List<dynamic> args) {
    var retValue = format;

    if (args.isEmpty) {
      return retValue;
    }

    for (int i = 0; i < args.length; i++) {
      retValue = retValue.replaceAll('{' '$i' '}', Func.toStr(args[i]));
    }

    return retValue;
  }

  static bool isIncrease(double percent) {
    var boo = false;

    if (percent > 0.0) {
      boo = true;
    }

    return boo;
  }

  /// Email validation
  static bool emailValidation(String email) {
    return EmailValidator.validate(email);
  }
}
