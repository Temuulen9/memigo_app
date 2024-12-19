import 'package:flutter/material.dart';
import 'package:memigo/api/lib/log.dart';
import 'package:memigo/widgets/button.dart';
import 'package:memigo/widgets/textfield.dart';
import 'package:memigo/widgets/textformfield.dart';

class WidgetScreen extends StatefulWidget {
  const WidgetScreen({super.key});

  @override
  State<WidgetScreen> createState() => _WidgetScreenState();
}

class _WidgetScreenState extends State<WidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets Screen'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text('TextFormField'),
            const SizedBox(height: 16),
            CTextFormField(
              hint: 'Нууц үг',
              // fillColor: const Color(0xFFF0F0F0),
              prefix: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 20),
                  Image.asset(
                    'assets/images/auth/flag_mn.png',
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 4),
                  const VerticalDivider(
                    thickness: 0.5,
                    color: Color(0xFF878787),
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
              suffix: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/auth/password.png',
                    width: 22,
                    height: 22,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CTextFormField(
              hint: 'Нэвтрэх нэр',
              fillColor: const Color(0xFFF0F0F0),
              suffix: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/auth/password.png',
                    width: 22,
                    height: 22,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const CTextFormField(
              hint: 'Нууц үг',
              fillColor: Color(0xFFF0F0F0),
            ),
            const SizedBox(height: 16),
            const CTextFormField(
              fillColor: Color(0xFFF0F0F0),
            ),
            const SizedBox(height: 16),
            const Text('Button'),
            const SizedBox(height: 16),
            Button(
              text: 'Нэвтрэх',
              gradient: const LinearGradient(colors: [Color(0xFFBB63FF), Color(0xFF3632D5)]),
              onClick: () {
                log.d('click');
              },
            ),
            const SizedBox(height: 16),
            Button(
              text: 'Бүртгүүлэх',
              bgcolor: Colors.white,
              type: ButtonTypes.secondary,
              gradient: const LinearGradient(colors: [Color(0xFFBB63FF), Color(0xFF3632D5)]),
              onClick: () {
                log.d('click');
              },
            ),
            const SizedBox(height: 16),
            Button(
              text: 'Устгах',
              type: ButtonTypes.tertiary,
              onClick: () {
                log.d('click');
              },
            ),
          ],
        ),
      ),
    );
  }
}
