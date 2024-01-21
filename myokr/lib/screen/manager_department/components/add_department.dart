import 'package:flutter/material.dart';

import '../../../item/constants.dart';
import '../../../item/random_string.dart';
import '../../../item/responsive.dart';
import '../../../model/firebase/department_model.dart';
import 'form_add_department.dart';

class AddDepartment extends StatefulWidget {
  final Function(Department) itemAdd;
  final String idPrevious;
  final String? nameDepartmentPrevious, nameCompanyPrevious;
  const AddDepartment({
    Key? key,
    required this.itemAdd,
    required this.idPrevious,
    this.nameDepartmentPrevious,
    this.nameCompanyPrevious,
  }) : super(key: key);

  @override
  State<AddDepartment> createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  TextEditingController nameDepartment = TextEditingController();
  TextEditingController nameLeader = TextEditingController();
  TextEditingController phoneLeader = TextEditingController();
  TextEditingController emailLeader = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                //CLOSE
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
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Logo")],
                ),
                // SizedBox(height: size.height * 0.04),
                widget.nameCompanyPrevious != null
                    ? Text(
                        widget.nameCompanyPrevious!,
                        style: const TextStyle(
                          color: kBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        "Trực thuộc phòng ban: ${widget.nameDepartmentPrevious}",
                        style: const TextStyle(
                          color: kBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                const Text(
                  "Nhập thông tin phòng ban mới:",
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: size.height * 0.04),

                //FORM INPUT
                Form(
                  key: _formKey,
                  child: FormAddDepartment(
                      nameDepartment: nameDepartment,
                      nameLeader: nameLeader,
                      phoneLeader: phoneLeader,
                      emailLeader: emailLeader),
                ),
                SizedBox(height: size.height * 0.04),
                //BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, top: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                        onHover: (value) {},
                        onPressed: () {
                          if (nameDepartment.text.isNotEmpty &&
                              nameLeader.text.isNotEmpty &&
                              phoneLeader.text.isNotEmpty &&
                              emailLeader.text.isNotEmpty) {
                            widget.itemAdd(Department(
                                id: "DPM${getRandomString(8)}",
                                idPrevious: widget.idPrevious,
                                nameLeader: nameLeader.text,
                                emailLeader: emailLeader.text,
                                phoneLeader: phoneLeader.text,
                                name: nameDepartment.text));
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
                        child: const Text("DONE"),
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
