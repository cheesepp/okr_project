import 'package:flutter/widgets.dart';
import 'package:myokr/screen/landing_page/landing_screen.dart';
import 'package:myokr/screen/login_page/login_screen.dart';
import 'package:myokr/screen/register_page/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LandingScreen.routename: (context) => const LandingScreen(),
  LoginScreen.routename: (context) => const LoginScreen(),
  RegisterScreen.routename: (context) => const RegisterScreen(),
};
