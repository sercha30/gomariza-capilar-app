import 'package:flutter/material.dart';
import 'package:flutter_gomariza_capilar_app/ui/appointment_detail_screen.dart';
import 'package:flutter_gomariza_capilar_app/ui/create_appointment_screen.dart';
import 'package:flutter_gomariza_capilar_app/ui/introduction_screen.dart';
import 'package:flutter_gomariza_capilar_app/ui/register_screen.dart';
import 'package:flutter_gomariza_capilar_app/ui/service_detail_screen.dart';
import 'package:flutter_gomariza_capilar_app/utils/constants/constants.dart';
import 'package:flutter_gomariza_capilar_app/utils/preferences/preferences_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'ui/login_screen.dart';

Future<void> main() async {
  await findSystemLocale();
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
    initializeDateFormatting('es', '');

    return MaterialApp(
      title: 'Gomariza Capilar App',
      initialRoute: '/',
      routes: {
        '/': (context) =>
            _showIntro ? const IntroScreen() : const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/serviceDetail': (context) => const ServiceDetailScreen(),
        '/appointmentDetail': (context) => const AppointmentDetailScreen(),
        '/newAppointment': (context) => const CreateAppointmentScreen()
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', '')],
      locale: const Locale('es', ''),
    );
  }
}
