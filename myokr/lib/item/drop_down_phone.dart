import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'constants.dart';

class ListPhone extends StatelessWidget {
  const ListPhone({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final TextEditingController phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: kTextColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            phoneNumber.text = number.phoneNumber!;
            // ignore: avoid_print
            print(number.phoneNumber);
          },
          onSaved: (PhoneNumber number) {
            // ignore: avoid_print
            print('On Saved: $number');
          },
          onInputValidated: (bool value) {
            // ignore: avoid_print
            print(value);
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          searchBoxDecoration: InputDecoration(
            labelText: "What is your business phone number ?",
            hintText: "Business phone number",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            enabledBorder: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
            border: outlineInputBorder(),
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: Colors.black),
          formatInput: false,
          maxLength: 9,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          cursorColor: Colors.black,
          inputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
            border: InputBorder.none,
            hintText: 'Business phone number',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
