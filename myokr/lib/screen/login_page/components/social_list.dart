import 'package:flutter/material.dart';
import 'package:myokr/item/social.dart';
import 'package:myokr/service/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

// --------------- APP ---------------//

class SocialIconList extends StatefulWidget {
  const SocialIconList({Key? key}) : super(key: key);

  @override
  State<SocialIconList> createState() => _SocialIconListState();
}

class _SocialIconListState extends State<SocialIconList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SocialIcon(
            icon: "assets/icons/connect-facebook.svg",
            press: () {
              context.read<FirebaseAuthMethods>().signInWithFacebook(context);
            },
          ),
          SocialIcon(
            icon: "assets/icons/connect-google.svg",
            press: () {
              context.read<FirebaseAuthMethods>().signInWithGoogle(context);
            },
          ),
          SocialIcon(
            icon: "assets/icons/connect-apple.svg",
            press: () {
              context.read<FirebaseAuthMethods>().signInWithAppleID(context);
            },
          ),
          SocialIcon(
            icon: "assets/icons/connect-microsoft.svg",
            press: () {
              context.read<FirebaseAuthMethods>().signInWithMicrosoft(context);
            },
          ),
        ],
      ),
    ]);
  }
}

// --------------- WEB ---------------//
class SocialCardList extends StatefulWidget {
  const SocialCardList({Key? key}) : super(key: key);

  @override
  State<SocialCardList> createState() => _SocialCardListState();
}

class _SocialCardListState extends State<SocialCardList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SocialCard(
              brand: "Facebook",
              icon: "assets/icons/connect-facebook.svg",
              press: () {
                context.read<FirebaseAuthMethods>().signInWithFacebook(context);
              },
            ),
            SocialCard(
              brand: "Google",
              icon: "assets/icons/connect-google.svg",
              press: () {
                context.read<FirebaseAuthMethods>().signInWithGoogle(context);
              },
            ),
            SocialCard(
              brand: "Apple ID",
              icon: "assets/icons/connect-apple.svg",
              press: () {
                context.read<FirebaseAuthMethods>().signInWithAppleID(context);
              },
            ),
            SocialCard(
              brand: "Office 365",
              icon: "assets/icons/connect-microsoft.svg",
              press: () {
                context
                    .read<FirebaseAuthMethods>()
                    .signInWithMicrosoft(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
