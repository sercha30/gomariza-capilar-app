import 'package:flutter/material.dart';
import 'package:flutter_gomariza_capilar_app/ui/introduction_screen.dart';
import 'package:flutter_gomariza_capilar_app/ui/register_screen.dart';
import 'package:flutter_gomariza_capilar_app/utils/constants/constants.dart';
import 'package:flutter_gomariza_capilar_app/utils/preferences/preferences_utils.dart';

import 'ui/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool _showIntro = true;
    PreferenceUtils.init().then((value) =>
        _showIntro = value.getBool(Constants.SHOW_INTRODUCTION) ?? true);

    return MaterialApp(
      title: 'Gomariza Capilar App',
      initialRoute: '/',
      routes: {
        '/': (context) =>
            _showIntro ? const IntroScreen() : const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
