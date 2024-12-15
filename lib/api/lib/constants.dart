///
const String mn = 'mn';

///
const String en = 'en';

class ConstApp {
  static const String cANDROID = 'ANDROID';
  static const String cIOS = 'iOS';
  static const String cAppDefaultCountryId = 'MNG';
  static const int cAppDefaultMobileMaxLen = 8;
  static const String cAppDefaultCountryPhonePrefix = '976';
  static const String cAppDefaultCountryPhonePrefixPlus = '+976';
}

/// Хугацааны нэгж
class ConstTermBasis {
  static const String cYEAR = 'Y'; // Жил
  static const String cMONTH = 'M'; // Сар
  static const String cWEEK = 'W'; // 7 хоног
  static const String cDAY = 'D'; // Өдөр

  static String getText(String termBasis) {
    var result = '';
    switch (termBasis) {
      case ConstTermBasis.cYEAR:
        result = 'жил';
        break;
      case ConstTermBasis.cMONTH:
        result = 'сар';
        break;
      case ConstTermBasis.cWEEK:
        result = '7 хоног';
        break;
      case ConstTermBasis.cDAY:
        result = 'өдөр';
        break;
    }

    return result;
  }
}

class FieldType {
  static const String fTextBox = "TEXTBOX";
  static const String fNumberBox = "NUMBERBOX";
  static const String fComboBox = "COMBOBOX";
  static const String fCheckBox = "CHECKBOX";
  static const String fImage = "IMAGE";
  static const String fFile = "FILE";
  static const String fToggle = "TOGGLE";
  static const String fLabel = "LABEL";
  static const String fDate = "DATE";
  static const String fWebView = "WEBVIEW";
}

enum ToastTypeEnum { defaultText, success, failed, warning, information }
