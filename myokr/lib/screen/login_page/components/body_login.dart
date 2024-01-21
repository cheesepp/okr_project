import 'package:flutter/material.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/item/divider.dart';
import 'package:myokr/item/link_of_text.dart';
import 'package:myokr/screen/login_page/components/social_list.dart';
import 'package:myokr/screen/register_page/register_screen.dart';

import '../../../item/responsive.dart';
import 'sign_in_form.dart';

class BodyLogin extends StatelessWidget {
  const BodyLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Responsive.isDesktop(context)
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: size.height,
                          decoration: const BoxDecoration(
                            color: kGreenLightColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * 0.09,
                              ),
                              const Text(
                                'Sign In to \nMy Application',
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // SizedBox(height: size.height * 0.04),
                              Image.asset(
                                "assets/images/login.png",
                                height: size.height * 0.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 64.0),
                            child: Login(size: size),
                          ),
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Login(size: size),
                  ),
          ),
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: !Responsive.isDesktop(context) ? size.height * 0.04 : 0),
        const Text(
          "Welcome Back",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Sign in with your email and password  \nor continue with social media",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: size.height * 0.04),
        const SignInForm(),
        SizedBox(height: size.height * 0.04),
        const OrDivider(),
        SizedBox(height: size.height * 0.04),
        Responsive.isDesktop(context)
            ? const SocialCardList()
            : const SocialIconList(),
        SizedBox(height: size.height * 0.04),
        LinkOfText(
          text: "Don't have an account ? ",
          textlink: " Sign Up",
          press: () => Navigator.of(context).pushNamed(
              RegisterScreen.routename),
        ),
      ],
    );
  }
}
