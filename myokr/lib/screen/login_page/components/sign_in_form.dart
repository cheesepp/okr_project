import 'package:flutter/material.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/item/default_button.dart';
import 'package:myokr/item/form_error.dart';
import 'package:myokr/item/input_form_field.dart';
import 'package:myokr/service/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? remember = false;

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

  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          FormError(errors: errors),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Spacer(),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          DefaultButton(
            text: "LOGIN",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                loginUser();
              }
            },
          ),
        ],
      ),
    );
  }
}
