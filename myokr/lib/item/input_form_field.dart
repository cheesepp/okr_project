import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    Key? key,
    required this.label,
    required this.hinttext,
    required this.obscure,
    required this.icon,
    required this.textController,
    required this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  final String label, hinttext, icon;
  final bool obscure;
  final TextEditingController textController;
  final Function(String) onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      controller: textController,
      obscureText: obscure,
      decoration: InputDecoration(
          labelText: label,
          hintText: hinttext,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
            child: SvgPicture.asset(
              icon,
              height: 18,
            ),
          )),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: const BorderSide(color: kTextColor),
      gapPadding: 10,
    );
  }
}
