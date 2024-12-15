import 'package:logger/logger.dart';

Logger log = Logger(printer: PrettyPrinter());

// Log log = Log.instance;
//
// class Log extends Logger {
// //  var logger = Logger(
// //    printer: PrettyPrinter(),
// //  );
// //
// //  var loggerNoStack = Logger(
// //    printer: PrettyPrinter(methodCount: 0),
// //  );
// //
//
//   Log._() : super(printer: PrettyPrinter()); //printer: PrettyPrinter(methodCount: 0),
//
//   static late Log _instance;
//
//   static Log get instance {
//     _instance = Log._();
//     return _instance;
//   }
//
//   static Log? get I => instance;
//
//   static bool allowVerboseLog = false;
//   static bool allowDebugLog = false;
//   static bool allowInfoLog = false;
//   static bool allowWarningLog = true;
//   static bool allowErrorLog = true;
//   static bool allowWtfLog = true;
//
//   static void setup({
//     bool allowVerboseLog = false,
//     bool allowDebugLog = false,
//     bool allowInfoLog = false,
//     bool allowWarningLog = true,
//     bool allowErrorLog = true,
//     bool allowWtfLog = true,
//   }) {
//     Log.allowVerboseLog = allowVerboseLog;
//     Log.allowDebugLog = allowDebugLog;
//     Log.allowInfoLog = allowInfoLog;
//     Log.allowWarningLog = allowWarningLog;
//     Log.allowErrorLog = allowErrorLog;
//     Log.allowWtfLog = allowWtfLog;
//   }
//
//   static void enable() {
//     setup(allowVerboseLog: true, allowDebugLog: true, allowInfoLog: true);
//   }
//
//   static void disable() {
//     setup(allowVerboseLog: false, allowDebugLog: false, allowInfoLog: false);
//   }
//
//   /// Log a message at level [Level.verbose].
//   @override
//   void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
//     if (allowVerboseLog) super.v(message, error, stackTrace);
//   }
//
//   /// Log a message at level [Level.debug].
//   @override
//   void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
//     if (allowDebugLog) super.d(message, error, stackTrace);
//   }
//
//   /// Log a message at level [Level.info].
//   @override
//   void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
//     if (allowInfoLog) super.i(message, error, stackTrace);
//   }
//
//   /// Log a message at level [Level.warning].
//   @override
//   void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
//     if (allowWarningLog) super.w(message, error, stackTrace);
//   }
//
//   /// Log a message at level [Level.error].
//   @override
//   void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
//     if (allowErrorLog) super.e(message, error, stackTrace);
//   }
//
//   /// Log a message at level [Level.wtf].
//   @override
//   void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
//     if (allowWtfLog) super.wtf(message, error, stackTrace);
//   }
// }
