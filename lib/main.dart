import 'package:flutter/material.dart';
import 'package:memigo/app.dart';
import 'package:memigo/app_configs/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  appStart();
  Globals app = Globals();
  await app.init();

  runApp(const MyApp());
}
