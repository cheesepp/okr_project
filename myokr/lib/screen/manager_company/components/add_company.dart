import 'package:flutter/material.dart';

import '../../../item/constants.dart';
import '../../../item/random_string.dart';
import '../../../item/responsive.dart';
import '../../../model/firebase/company_mode.dart';
import 'form_add_company.dart';

class AddCompany extends StatefulWidget {
  final Function(Company) itemAdd;
  final String userID;
  const AddCompany({Key? key, required this.itemAdd, required this.userID})
      : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController businessName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController timezones = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
      child: Container(
        height: Responsive.isMobile(context) ? size.height : size.height * 0.7,
        width: Responsive.isMobile(context)
            ? size.width
            : size.width < 1280
                ? 900
                : size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(47),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 4, vertical: defaultPadding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("assets/icons/close.png"),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Logo")],
                ),
                const SizedBox(height: defaultPadding),
                Form(
                  key: _formKey,
                  child: FormAddCompany(
                    businessName: businessName,
                    phoneNumber: phoneNumber,
                    country: country,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, top: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                        onHover: (value) {},
                        onPressed: () {
                          if (businessName.text.isNotEmpty &&
                              country.text.isNotEmpty &&
                              phoneNumber.text.isNotEmpty) {
                            widget.itemAdd(
                              Company(
                                id: "CPN${getRandomString(8)}",
                                userID: widget.userID,
                                name: businessName.text,
                                country: country.text,
                                phone: phoneNumber.text,
                                date: DateTime.now(),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: kBlackColor,
                          primary: kBlackColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        child: const Text("GET STARTED"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
