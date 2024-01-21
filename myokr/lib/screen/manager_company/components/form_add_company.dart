import 'package:flutter/material.dart';

import '../../../item/constants.dart';
import '../../../item/drop_down_country.dart';
import '../../../item/drop_down_phone.dart';
import '../../../item/input_form_field.dart';
import '../../../item/responsive.dart';

class FormAddCompany extends StatelessWidget {
  const FormAddCompany({
    Key? key,
    required this.businessName,
    required this.phoneNumber,
    required this.country,
  }) : super(key: key);

  final TextEditingController businessName, phoneNumber, country;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return !Responsive.isDesktop(context)
        ? Column(
            children: [
              //Business name
              InputFormField(
                label: " What is your business name ?",
                hinttext: "Business name",
                obscure: false,
                textController: businessName,
                icon: '',
                onChanged: (String x) {},
              ),
              const SizedBox(height: defaultPadding),
              //Country
              DropdownCountry(
                countryController: country,
              ),
              const SizedBox(height: defaultPadding),

              //Phone number
              ListPhone(phoneNumber: phoneNumber),
            ],
          )
        : Column(
            children: [
              //Business name
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InputFormField(
                      label: " What is your business name ?",
                      hinttext: "Business name",
                      obscure: false,
                      textController: businessName,
                      icon: '',
                      onChanged: (String x) {},
                    ),
                  ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 1,
                    child: DropdownCountry(
                      countryController: country,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),

              //Country

              //Phone number
              ListPhone(phoneNumber: phoneNumber),
            ],
          );
  }
}
