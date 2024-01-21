import 'package:flutter/material.dart';

import '../../../item/constants.dart';
import '../../../item/input_form_field.dart';
import '../../../item/responsive.dart';

class FormAddDepartment extends StatelessWidget {
  const FormAddDepartment({
    Key? key,
    required this.nameDepartment,
    required this.nameLeader,
    required this.phoneLeader,
    required this.emailLeader,
  }) : super(key: key);

  final TextEditingController nameDepartment;
  final TextEditingController nameLeader;
  final TextEditingController phoneLeader;
  final TextEditingController emailLeader;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return !Responsive.isDesktop(context)
        ? SingleChildScrollView(
            child: Column(
              children: [
                InputFormField(
                  label: " What is your department name ?",
                  hinttext: "Department name",
                  obscure: false,
                  textController: nameDepartment,
                  icon: '',
                  onChanged: (String x) {},
                ),
                const SizedBox(height: defaultPadding),
                InputFormField(
                  label: " What is leader'name ?",
                  hinttext: "Leader'name",
                  obscure: false,
                  textController: nameLeader,
                  icon: '',
                  onChanged: (String x) {},
                ),
                const SizedBox(height: defaultPadding),
                InputFormField(
                  label: " What is leader'phone ?",
                  hinttext: "Leader'phone",
                  obscure: false,
                  textController: phoneLeader,
                  icon: '',
                  onChanged: (String x) {},
                ),
                const SizedBox(height: defaultPadding),
                InputFormField(
                  label: " What is leader'email ?",
                  hinttext: "Leader'email",
                  obscure: false,
                  textController: emailLeader,
                  icon: '',
                  onChanged: (String x) {},
                ),
              ],
            ),
          )
        : Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InputFormField(
                      label: " What is your department name ?",
                      hinttext: "Department name",
                      obscure: false,
                      textController: nameDepartment,
                      icon: '',
                      onChanged: (String x) {},
                    ),
                  ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 1,
                    child: InputFormField(
                      label: " What is leader'name ?",
                      hinttext: "Leader'name",
                      obscure: false,
                      textController: nameLeader,
                      icon: '',
                      onChanged: (String x) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InputFormField(
                      label: " What is leader'phone ?",
                      hinttext: "Leader'phone",
                      obscure: false,
                      textController: phoneLeader,
                      icon: '',
                      onChanged: (String x) {},
                    ),
                  ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 1,
                    child: InputFormField(
                      label: " What is leader'email ?",
                      hinttext: "Leader'email",
                      obscure: false,
                      textController: emailLeader,
                      icon: '',
                      onChanged: (String x) {},
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
