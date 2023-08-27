import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentalove_app/ui/pages/counseling.dart';
import 'package:mentalove_app/ui/pages/daily_content.dart';
import 'package:mentalove_app/ui/pages/detail.dart';
import 'package:mentalove_app/ui/pages/history.dart';
import 'package:mentalove_app/ui/pages/landing_page.dart';
import 'package:mentalove_app/ui/pages/login_page.dart';
import 'package:mentalove_app/ui/pages/main_page.dart';
import 'package:mentalove_app/ui/pages/psikiater_page.dart';
import 'package:mentalove_app/ui/pages/psikolog_page.dart';
import 'package:mentalove_app/ui/pages/signup_page.dart';
import 'package:mentalove_app/ui/pages/tell_us.dart';
import 'package:mentalove_app/ui/pages/pembayaran.dart';

import 'cubit/page_cubit.dart';
import 'ui/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, routes: {
        '/': (context) => const SplashScreen(),
        '/main-page': (context) => const MainPage(),
        '/landing-page': (context) => const LandingPage(),
        '/counseling': (context) => const Counseling(),
        '/login-page': (context) => const LoginPage(),
        '/signup-page': (context) => const SignupPage(),
        '/detail': (context) => const Detail(),
        '/history': (context) => const HistoryPage(),
        '/daily': (context) => const DailyContentPage(),
        '/tellus': (context) => const TellUsPage(),
        '/psikolog-page': (context) => const PsikologPage(),
        '/pembayaran': (context) => const Pembayaran(),
        '/psikiater-page': (context) => const PsikiaterPage(),
      }),
    );
  }
}
