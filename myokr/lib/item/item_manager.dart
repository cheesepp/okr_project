import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/firebase/company_mode.dart';
import '../model/firebase/department_model.dart';
import 'constants.dart';
import 'responsive.dart';

class ItemManager extends StatelessWidget {
  final Company? itemCompany;
  final Department? itemDepartment;
  final VoidCallback press1, press2, press3;
  const ItemManager(
      {Key? key,
      this.itemCompany,
      this.itemDepartment,
      required this.press1,
      required this.press3,
      required this.press2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
        // border: Border.all(color: kBlackColor, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(23),
        ),
      ),
      child: Responsive(
        mobile: ViewMobiel(
          itemCompany: itemCompany,
          itemDepartment: itemDepartment,
          press1: press1,
          press2: press2,
        ),
        desktop: ViewWebAndTablet(
          itemCompany: itemCompany,
          itemDepartment: itemDepartment,
          press1: press1,
          press2: press2,
          press3: press3,
        ),
        tablet: ViewWebAndTablet(
          itemCompany: itemCompany,
          itemDepartment: itemDepartment,
          press1: press1,
          press2: press2,
          press3: press3,
        ),
      ),
    );
  }
}

class ViewWebAndTablet extends StatefulWidget {
  final Company? itemCompany;
  final Department? itemDepartment;
  final VoidCallback press1, press2, press3;

  const ViewWebAndTablet({
    Key? key,
    this.itemCompany,
    this.itemDepartment,
    required this.press1,
    required this.press3,
    required this.press2,
  }) : super(key: key);

  @override
  State<ViewWebAndTablet> createState() => _ViewWebAndTabletState();
}

class _ViewWebAndTabletState extends State<ViewWebAndTablet> {
  Color colorDepartment = kBlackColor;
  Color colorEmployee = kBlackColor;
  TextDecoration textDepartment = TextDecoration.none;
  TextDecoration textEmployee = TextDecoration.none;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.press3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: kBlackColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: widget.press1,
                        child: Text(
                          widget.itemCompany != null
                              ? "Công ty: ${widget.itemCompany!.name}"
                              : "Phòng ban: ${widget.itemDepartment!.name}",
                          style: const TextStyle(
                            fontSize: defaultFontsize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.itemCompany != null
                            ? "Ngày tạo: ${DateFormat.yMMMd().format(widget.itemCompany!.date)}"
                            : "Trưởng phòng: ${widget.itemDepartment!.nameLeader}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: defaultFontsize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.itemCompany != null
                            ? "Quốc Gia: ${widget.itemCompany!.country}"
                            : "Email: ${widget.itemDepartment!.emailLeader}",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: defaultFontsize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onHover: (event) {
                      setState(() {
                        colorDepartment = Colors.blue;
                        textDepartment = TextDecoration.underline;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        colorDepartment = kBlackColor;
                        textDepartment = TextDecoration.none;
                      });
                    },
                    child: GestureDetector(
                      onTap: widget.press1,
                      child: Text(
                        "Danh sách phòng ban",
                        style: TextStyle(
                            color: colorDepartment,
                            decoration: textDepartment,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, bottom: 24.0, right: 24.0),
              child: Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onHover: (event) {
                      setState(() {
                        colorEmployee = Colors.blue;
                        textEmployee = TextDecoration.underline;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        colorEmployee = kBlackColor;
                        textEmployee = TextDecoration.none;
                      });
                    },
                    child: GestureDetector(
                      onTap: widget.press2,
                      child: Text(
                        "Danh sách nhân viên",
                        style: TextStyle(
                            color: colorEmployee,
                            decoration: textEmployee,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewMobiel extends StatefulWidget {
  final Company? itemCompany;
  final Department? itemDepartment;
  final VoidCallback press1, press2;

  const ViewMobiel({
    Key? key,
    this.itemCompany,
    this.itemDepartment,
    required this.press1,
    required this.press2,
  }) : super(key: key);

  @override
  State<ViewMobiel> createState() => _ViewMobielState();
}

class _ViewMobielState extends State<ViewMobiel> {
  Color colorDepartment = kBlackColor;
  Color colorEmployee = kBlackColor;
  TextDecoration textDepartment = TextDecoration.none;
  TextDecoration textEmployee = TextDecoration.none;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: kBlackColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.itemCompany != null
                      ? widget.itemCompany!.name
                      : "Phòng ban: ${widget.itemDepartment!.name}",
                  style: const TextStyle(
                    fontSize: defaultFontsize,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.itemCompany != null
                      ? "Ngày tạo: ${DateFormat.yMMMd().format(widget.itemCompany!.date)}"
                      : "Trưởng phòng: ${widget.itemDepartment!.nameLeader}",
                  style: const TextStyle(
                    fontSize: defaultFontsize,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.itemCompany != null
                      ? "Quốc Gia: ${widget.itemCompany!.country}"
                      : "Email: ${widget.itemDepartment!.emailLeader}",
                  style: const TextStyle(
                    fontSize: defaultFontsize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (event) {
              setState(() {
                colorDepartment = Colors.blue;
                textDepartment = TextDecoration.underline;
              });
            },
            onExit: (event) {
              setState(() {
                colorDepartment = kBlackColor;
                textDepartment = TextDecoration.none;
              });
            },
            child: GestureDetector(
              onTap: widget.press1,
              child: Text(
                "Danh sách phòng ban",
                style: TextStyle(
                  color: colorEmployee,
                  decoration: textEmployee,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18, bottom: 18, right: 18),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (event) {
              setState(() {
                colorDepartment = Colors.blue;
                textDepartment = TextDecoration.underline;
              });
            },
            onExit: (event) {
              setState(() {
                colorDepartment = kBlackColor;
                textDepartment = TextDecoration.none;
              });
            },
            child: GestureDetector(
              onTap: widget.press2,
              child: Text(
                "Danh sách nhân viên",
                style: TextStyle(
                  color: colorEmployee,
                  decoration: textEmployee,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
