import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/firebase/company_mode.dart';
import '../model/firebase/department_model.dart';
import 'constants.dart';

class Information extends StatelessWidget {
  const Information({
    Key? key,
    this.itemDepartmnet,
    this.itemCompany,
  }) : super(key: key);

  final Department? itemDepartmnet;
  final Company? itemCompany;

  @override
  Widget build(BuildContext context) {
    return itemCompany != null
        ? Column(
            children: [
              InputInformation(
                label: "Tên công ty: ",
                content: itemCompany!.name,
              ),
              InputInformation(
                label: "Ngày tạo: ",
                content: DateFormat.yMMMd().format(itemCompany!.date),
              ),
              InputInformation(
                label: "Quốc Gia: ",
                content: itemCompany!.country,
              ),
              InputInformation(
                label: "Số điện thoại liên hệ: ",
                content: itemCompany!.phone,
              ),
              const InputInformation(
                label: "Tổng số lượng phòng ban: ",
                content: "0",
              ),
              const InputInformation(
                label: "Tổng số lượng nhân viên: ",
                content: "0",
              )
            ],
          )
        : Column(
            children: [
              InputInformation(
                label: "Tên phòng ban: ",
                content: itemDepartmnet!.name,
              ),
              InputInformation(
                label: "Trưởng phòng: ",
                content: itemDepartmnet!.nameLeader,
              ),
              InputInformation(
                label: "Email: ",
                content: itemDepartmnet!.emailLeader,
              ),
              InputInformation(
                label: "Số điện thoại trưởng phòng: ",
                content: itemDepartmnet!.phoneLeader,
              ),
              const InputInformation(
                label: "Tổng số lượng phòng ban: ",
                content: "0",
              ),
              const InputInformation(
                label: "Tổng số lượng nhân viên: ",
                content: "0",
              )
            ],
          );
  }
}

class InputInformation extends StatelessWidget {
  const InputInformation({
    Key? key,
    required this.label,
    required this.content,
    this.textEditingController,
  }) : super(key: key);
  final String label, content;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(label)),
          const SizedBox(width: defaultPadding * 2),
          Expanded(flex: 1, child: Text(content)),
          const SizedBox(width: defaultPadding * 2),

          const Expanded(flex: 1, child: Icon(Icons.edit)),
          const Spacer(
            flex: 2,
          )
          // TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     hintText: 'Enter a search term',
          //   ),
          //   controller: textEditingController,
          // ),
        ],
      ),
    );
  }
}
