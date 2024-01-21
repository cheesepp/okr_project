import 'package:flutter/material.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/item/default_button.dart';
import 'package:myokr/item/form_error.dart';
import 'package:myokr/item/input_form_field.dart';
import 'package:myokr/service/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //Email
          InputFormField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              }
              if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              }
              if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            label: "Email",
            hinttext: "Enter your email",
            icon: "assets/icons/Mail.svg",
            obscure: false,
            textController: emailController,
          ),
          const SizedBox(
            height: 20,
          ),
          //Password
          InputFormField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              }
              if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            label: "Passord",
            hinttext: "Enter your password",
            icon: "assets/icons/Lock.svg",
            obscure: true,
            textController: passwordController,
          ),
          const SizedBox(
            height: 20,
          ),
          //Conform - Password
          InputFormField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (value.isNotEmpty &&
                  passwordController.text == conformpasswordController.text) {
                removeError(error: kMatchPassError);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              }
              if ((passwordController.text != value)) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            label: "Confirm Passord",
            hinttext: "Enter your password",
            icon: "assets/icons/Lock.svg",
            obscure: true,
            textController: conformpasswordController,
          ),
          //Show - Error
          FormError(errors: errors),
          SizedBox(height: size.height * 0.04),

          //Button SIGN UP
          DefaultButton(
            text: "SIGN UP",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                signUpUser();
                // signUpUserAPI();
              }
            },
          ),
        ],
      ),
    );
  }
}
