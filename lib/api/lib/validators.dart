import 'package:flutter/services.dart';

//import 'dart:math' as math;
import 'func.dart';

const String maskChar = '*';
//const String MOBILE_MASK = '****';

abstract class StringValidator {
  bool isValid(String value);
}

class RegexValidator implements StringValidator {
  RegexValidator({this.regexSource});

  final String? regexSource;

  /// value: the input string
  /// returns: true if the input string is a full match for regexSource
  @override
  bool isValid(String value) {
    try {
      final regex = RegExp(regexSource!);
      final matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  ValidatorInputFormatter({this.editingValidator});

  final StringValidator? editingValidator;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = editingValidator!.isValid(oldValue.text);
    final newValueValid = editingValidator!.isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }
}

class DecimalNumberEditingRegexValidator extends RegexValidator {
  DecimalNumberEditingRegexValidator()
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,3}))(\\.[0-9]{0,2})?\$");
}

class DecimalNumberEditingRegexValidator2 extends RegexValidator {
  DecimalNumberEditingRegexValidator2({int maxLength = 10})
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,$maxLength}))?\$");
}

class DecimalNumberSubmitValidator implements StringValidator {
  @override
  bool isValid(String value) {
    try {
      final number = Func.toDouble(value);
      return number > 0.0;
    } catch (e) {
      return false;
    }
  }
}

class PrefixTextInputFormatter extends TextInputFormatter {
  PrefixTextInputFormatter({this.prefix = '\$'});

  final String prefix;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    int selectionIndex = newValue.selection.end;
    //final TextSelection newSelection = newValue.selection.copyWith();

    return TextEditingValue(
      text: '$prefix$newValue',
      selection: TextSelection.collapsed(offset: selectionIndex),
      // newSelection,
      composing: TextRange.empty,
    );
  }
}

class EmailEditingRegexValidator extends RegexValidator {
  EmailEditingRegexValidator()
      : super(
            regexSource:
                "^[a-zA-Z0-9_.+-]*(@([a-zA-Z0-9-]*(\\.[a-zA-Z0-9-]*)?)?)?\$");
}

class EmailSubmitRegexValidator extends RegexValidator {
  EmailSubmitRegexValidator()
      : super(
            regexSource: "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)");
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String? mask;
  final String? separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  }) {
    assert(mask != null);
    assert(separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask!.length) return oldValue;
        if (newValue.text.length < mask!.length &&
            mask![newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

class FloatTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      return TextEditingValue(
        text: Func.toMoneyStr(newValue.text),
        selection: TextSelection.collapsed(
          offset: newValue.selection.end,
        ),
      );
    }
    return newValue;
  }
}

class Validators {
//  static final RegExp _emailRegExp = RegExp(
//    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
//  );

//  static final RegExp _passwordRegExp = RegExp(
//    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
//  );

  // static final RegExp _mobileRegExpDefault = RegExp(
  //   r'^[0-9]{8}$',
  // );

//  static final RegExp _passwordRegExp = RegExp(
//    r'^[0-9]$',
//  );

  static bool isValidEmail(String email) {
    return true; // _emailRegExp.hasMatch(email);
  }

  static bool isValidLoginName(String email) {
    return true; // _emailRegExp.hasMatch(email);
  }

  static bool isValidMobile(
      String mobile, String appUserMobile, int mobileMinLen, int mobileMaxLen) {
    // print('mobile: $mobile, appUserMobile: $appUserMobile, mobileMaxLen: $mobileMaxLen');
    //mobile ??= '';
    // appUserMobile ??= '';

    //if (mobile.contains(MASK_CHAR) && mobile.length == mobileMaxLen && !Func.isNullEmpty(appUserMobile))
    if (mobile.isNotEmpty) {
      if (mobile.contains(maskChar)) {
        if (mobile.length == appUserMobile.length) {
          // Өөрчлөгдөөгүй
          mobile = appUserMobile;
        } else {
          // mobile
        }
      } else {
        // mobile
      }
    } else {
      // mobile
    }

    return isValidLength(mobile, mobileMaxLen,
        mobileMinLen); //RegExp('^[0-9]{$mobileMaxLen}\$').hasMatch(mobile) ?? false;
  }

  static bool isMobileChangedOrEmpty(String mobile, String appUserMobile) {
    // print('mobile: $mobile, appUserMobile: $appUserMobile');
    //mobile ??= '';
    //appUserMobile ??= '';

    if (mobile.isEmpty) {
      return true;
    } else {
      if (appUserMobile.isEmpty) {
        return false;
      } else {
        return mobile.length != appUserMobile.length;
      }
    }
  }

  ///validation helper functions
  static String getValidMobile(String inputMobile, String cachedMobile,
      {bool? hasSpace})
  //, int minLen, int maxLen) {
  {
    // inputMobile = inputMobile ?? '';
    // Check mobile changed?
    //if (inputMobile.contains(MASK_CHAR) && (inputMobile.length >= minLen || inputMobile.length <= maxLen) && !Func.isNullEmpty(cachedMobile)) {
    if (inputMobile.contains(maskChar) &&
        inputMobile.length == cachedMobile.length) {
      // Өөрчлөгдөөгүй
      return cachedMobile;
    } else {
      // Өөрчлөгдсөн
      if (hasSpace ?? false) {
        return inputMobile.trimRight(); // clearSpace(inputMobile);
      } else {
        return inputMobile.replaceAll(' ', '');
      }
    }

    // String _getMobile() {
    //   var mobile = _mobileText.getValue() ?? '';
    //   // Check mobile changed?
    //   if (mobile.contains(MASK_CHAR) && mobile.length == _mobileMaxLen && !Func.isNullEmpty(app.user.mobile)) {
    //     // Өөрчлөгдөөгүй
    //     return app.user.mobile;
    //   } else {
    //     // Өөрчлөгдсөн
    //     return mobile.replaceAll(' ', '');
    //   }
    // }
  }

  static bool isValidLength(String str, int maxLen, int minLen) {
    // str ??= '';

    if (str.length < minLen || str.length > maxLen) {
      return false;
    }

    return true;
  }

  static bool isValidPin(
    String pin,
  ) {
    // pin ??= '';
    return pin.isNotEmpty && (pin.length == 4 || pin.length == 6);

    //_passwordRegExp.hasMatch(password);
//    return true;
  }

  static bool isValidPinLength(String str, int maxLen, int minLen) {
    /// Оруулсан  нууц үг Pinpolicy-гийн хооронд байгаа эсэхийг шалгана.
    // str ??= '';
    if (str.length < minLen || str.length > maxLen) {
      return false;
    }

    return true;
  }
}
