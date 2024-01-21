import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myokr/item/show_snack_bar.dart';
import 'package:myokr/model/firebase/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'firestore_service.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String? connect;

  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

// RESET PASSWORD
  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // EMAIL SIGN UP
  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.sendEmailVerification();
      // await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
      showSnackBar(context, e.message!);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // FACEBOOK SIGN IN
  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      if (kIsWeb) {
        FacebookAuthProvider facebookProvider = FacebookAuthProvider();

        facebookProvider.addScope('email');
        facebookProvider.addScope('public_profile');
        facebookProvider.setCustomParameters({
          'display': 'popup',
        });

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(facebookProvider);
        checkNewUser(userCredential);
      } else {
        final LoginResult loginResult =
            await FacebookAuth.instance.login(permissions: [
          'public_profile',
          'email',
        ]);

        if (loginResult.status == LoginStatus.success) {
          final OAuthCredential credential =
              FacebookAuthProvider.credential(loginResult.accessToken!.token);
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          connect = "facebook";
          checkNewUser(userCredential);
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    } on PlatformException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

        UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);
        if (userCredential.user != null) {
          checkNewUser(userCredential);
        }
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          connect = "google";
          checkNewUser(userCredential);
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    } on PlatformException catch (e) {
      showSnackBar(context, e.message!);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //MICROSOFT SIGN IN
  Future<void> signInWithMicrosoft(BuildContext context) async {
    try {
      if (kIsWeb) {
        final provider = OAuthProvider("microsoft.com");
        provider.addScope('email');
        provider.addScope('openid');
        provider.addScope('offline_access');
        provider.addScope('profile');
        provider.setCustomParameters(
          {
            'tenant': 'd4b0ca70-ba37-4643-9030-74d277080ec1',
            'prompt': 'login',
          },
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(provider);
        checkNewUser(userCredential);
      } else {
        OAuthCredential microsoftUser =
            await FirebaseAuthOAuth().signInOAuth("microsoft.com", [
          "email openid profile offline_access"
        ], {
          'tenant': 'd4b0ca70-ba37-4643-9030-74d277080ec1',
          'prompt': 'login',
        });
        UserCredential userCredential =
            await _auth.signInWithCredential(microsoftUser);
        checkNewUser(userCredential);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    } on PlatformException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  //APPLE SIGN IN
  Future<void> signInWithAppleID(BuildContext context) async {
    if (kIsWeb) {
      final provider = OAuthProvider("apple.com")
        ..addScope('email')
        ..addScope('name');
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(provider);
      checkNewUser(userCredential);
    } else {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      checkNewUser(userCredential);
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      switch (connect) {
        case "google":
          await googleSignIn.disconnect();
          await _auth.signOut();

          break;
        case "facebook":
          await FacebookAuth.instance.logOut();
          await _auth.signOut();

          break;
        default:
          await _auth.signOut();
          break;
      }
      connect = null;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    } on PlatformException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  void checkNewUser(UserCredential userCredential) {
    if (userCredential.user != null) {
      if (userCredential.additionalUserInfo!.isNewUser) {
        FirestoreService(uid: userCredential.user!.uid).addUser(UserData(
            email: userCredential.user!.email ?? "",
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? ""));
      }
    }
  }
}
