import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class DropdownCountry extends StatelessWidget {
  const DropdownCountry({
    Key? key,
    required this.countryController,
  }) : super(key: key);

  final TextEditingController countryController;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>(
      popupProps: const PopupProps.menu(
        searchDelay: Duration(microseconds: 300),
        isFilterOnline: false,
        showSearchBox: true,
        constraints: BoxConstraints(maxHeight: 300),
      ),
      asyncItems: (value) async {
        return await getCountry('name');
      },
      onChanged: (value) {
        if (value != null) countryController.text = value;
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: "Where is your business located ?",
          hintText: "Country in menu mode",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
        ),
      ),
    );
  }

  Future<List<dynamic>> getCountry(String? value) async {
    var re = await http.get(
      Uri.parse("https://restcountries.com/v2/all"),
    );

    try {
      if (re.statusCode == 200) {
        if (value == null) {
          return [];
        }
        return await jsonDecode(re.body)
            .map(
              (e) => e[value],
            )
            .toList();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return [];
  }
}
