import 'package:flutter/material.dart';

// --------------- COLOR --------------- //
const kBlackColor = Color.fromRGBO(33, 37, 41, 1);
const kGreyColor = Color.fromRGBO(153, 153, 153, 1);
const kGreenLightColor = Color.fromRGBO(190, 219, 212, 0.28);
const kTextColor = Color(0xFF757575);
const kGreyColorWidget = Color.fromARGB(255, 211, 221, 230);
const kRedColor = Color.fromARGB(255, 243, 142, 134);

// --------------- SPACE --------------- //
const double defaultPadding = 18.0;
const double defaultHorizontalPage = 112.0;
const double defaultFontsize = 20.0;
const kDefaultDuration = Duration(milliseconds: 250);

// --------------- ERROR --------------- //
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kTextColor),
    gapPadding: 10,
  );
}
