import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/firebase/company_mode.dart';
import '../model/firebase/department_model.dart';
import 'constants.dart';

class ItemDetailManager extends StatelessWidget {
  const ItemDetailManager({
    Key? key,
    this.itemDepartmnet,
    this.itemCompany,
  }) : super(key: key);

  final Department? itemDepartmnet;
  final Company? itemCompany;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thông tin nhanh",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            Text(
              itemCompany != null
                  ? "Tên công ty: ${itemCompany!.name}"
                  : itemDepartmnet != null
                      ? "Tên phòng ban: ${itemDepartmnet!.name}"
                      : '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              itemCompany != null
                  ? "Ngày tạo: ${DateFormat.yMMMd().format(itemCompany!.date)}"
                  : itemDepartmnet != null
                      ? "Trưởng phòng: ${itemDepartmnet!.nameLeader}"
                      : '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              itemCompany != null
                  ? "Quốc Gia: ${itemCompany!.country}"
                  : itemDepartmnet != null
                      ? "Email: ${itemDepartmnet!.emailLeader}"
                      : '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              itemCompany != null
                  ? "Số điện thoại liên hệ: ${itemCompany!.phone}"
                  : itemDepartmnet != null
                      ? "Số điện thoại trưởng phòng: ${itemDepartmnet!.phoneLeader}"
                      : '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              itemCompany != null
                  ? "Tổng số lượng phòng ban: 0"
                  : itemDepartmnet != null
                      ? "Tổng số lượng phòng ban: 0"
                      : '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              itemCompany != null
                  ? "Tổng số lượng nhân viên: 0"
                  : itemDepartmnet != null
                      ? "Tổng số lượng nhân viên: 0"
                      : '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
