import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myokr/item/show_snack_bar.dart';
import 'package:myokr/screen/homepage.dart';

import 'package:myokr/screen/register_page/components/body_register.dart';
import 'package:provider/provider.dart';

import '../manager_company/manager_company_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static String routename = "/register";
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    try {
      if (firebaseUser != null) {
        return const HomePage();
      }
      return const BodyRegister();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    } on PlatformException catch (e) {
      showSnackBar(context, e.message!);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return const BodyRegister();
  }
}
