import 'package:flutter/material.dart';
import 'package:memigo/screens/login_screen/login_screen.dart';
import 'package:memigo/theme.dart';
import 'package:memigo/util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Memigo',
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const LoginScreen(),
    );
  }
}
