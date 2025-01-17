import 'package:flutter/material.dart';
import 'package:memigo/screens/login_screen/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;

    // TextTheme textTheme = createTextTheme(context, "Roboto", "Inter");
    // MaterialTheme theme = MaterialTheme(textTheme);

    return const MaterialApp(
      title: 'Memigo',
      debugShowCheckedModeBanner: false,
      // theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: LoginScreen(),
    );
  }
}
