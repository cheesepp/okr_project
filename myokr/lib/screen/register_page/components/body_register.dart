import 'package:flutter/material.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/item/divider.dart';
import 'package:myokr/item/link_of_text.dart';
import 'package:myokr/screen/login_page/login_screen.dart';
import 'package:myokr/screen/register_page/components/social_list.dart';

import '../../../item/responsive.dart';
import 'sign_up_form.dart';

class BodyRegister extends StatelessWidget {
  const BodyRegister({Key? key}) : super(key: key);

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
                                'Sign Up to \nMy Application',
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
                            child: SignUp(size: size),
                          ),
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SignUp(size: size),
                  ),
          ),
        ),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({
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
          "SIGN UP",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Sign up with your email and password",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: size.height * 0.04),
        const SignUpForm(),
        SizedBox(height: size.height * 0.04),
        const OrDivider(),
        SizedBox(height: size.height * 0.04),
        Responsive.isDesktop(context)
            ? const SocialCardList()
            : const SocialIconList(),
        SizedBox(height: size.height * 0.04),
        LinkOfText(
          text: "Already have an Account? ",
          textlink: " Sign In",
          press: () => Navigator.of(context).pushNamed(LoginScreen.routename),
        )
      ],
    );
  }
}
