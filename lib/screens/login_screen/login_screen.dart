import 'package:flutter/material.dart';
import 'package:memigo/api/lib/log.dart';
import 'package:memigo/screens/widgets_screen/widget_screen.dart';
import 'package:memigo/widgets/button.dart';
import 'package:memigo/widgets/textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    // Listen to focus changes
    _phoneNumberFocusNode.addListener(() {
      setState(() {
        _isFocused = _phoneNumberFocusNode.hasFocus;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _isFocused = _passwordFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF3632D5),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Бүртгэлтэй юу хө?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Button(
                            text: 'Бүртгүүлэх',
                            type: ButtonTypes.secondary,
                            bgcolor: Colors.transparent,
                            size: ButtonSizes.small,
                            textStyle: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            onClick: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const WidgetScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const Expanded(
                        child: Center(
                            child: Text(
                      'Memigo',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )))
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Positioned.fill(
                      left: 23,
                      right: 23,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(187, 99, 255, 0.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(42),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'Тавтай морил',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  CTextFormField(
                                    label: 'Нэвтрэх нэр',
                                    autofocus: false,
                                    focusNode: _phoneNumberFocusNode,
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
                                          'assets/images/auth/user_rounded.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  CTextFormField(
                                    label: 'Нууц үг',
                                    autofocus: false,
                                    focusNode: _passwordFocusNode,
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
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Button(
                                    text: 'Нэвтрэх',
                                    gradient: const LinearGradient(colors: [Color(0xFFBB63FF), Color(0xFF3632D5)]),
                                    onClick: () {
                                      log.d('click');
                                    },
                                  ),
                                  AnimatedCrossFade(
                                    duration: Durations.short1,
                                    crossFadeState: _isFocused ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                    firstChild: const Column(
                                      children: [
                                        SizedBox(height: 24),
                                        Row(
                                          children: [
                                            Expanded(child: Divider()),
                                            SizedBox(width: 16),
                                            Text(
                                              'Эсвэл',
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Color(0xFF808080),
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(child: Divider()),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Button(
                                                text: 'Google',
                                                type: ButtonTypes.secondary,
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Button(
                                                text: 'Facebook',
                                                type: ButtonTypes.secondary,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    secondChild: const SizedBox.shrink(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
