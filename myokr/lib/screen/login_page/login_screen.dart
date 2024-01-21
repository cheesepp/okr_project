import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myokr/item/show_snack_bar.dart';
import 'package:myokr/screen/homepage.dart';

import 'package:provider/provider.dart';

import '../manager_company/manager_company_screen.dart';
import 'components/body_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routename = "/login";
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    try {
      if (firebaseUser != null) {
        return const HomePage();
      }
      return const BodyLogin();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    } on PlatformException catch (e) {
      showSnackBar(context, e.message!);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return const BodyLogin();
  }
}
