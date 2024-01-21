import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myokr/item/item_detail_manager.dart';
import 'package:provider/provider.dart';
import '../../item/constants.dart';
import '../../item/divider.dart';
import '../../item/item_manager.dart';
import '../../item/responsive.dart';
import '../../item/tab_control.dart';
import '../../model/firebase/department_model.dart';
import '../../provider/firebase/department_provider.dart';
import 'components/add_department.dart';

class ManagerDepartmentScreen extends StatefulWidget {
  final String idPrevious;
  final String? nameCompanyPrevious,
      countryPrevious,
      nameDepartmentPrevious,
      nameLeaderPrevious,
      phoneLeaderPrevious,
      emailLeaderPrevious;
  final DateTime? dateTimePrevious;
  const ManagerDepartmentScreen({
    Key? key,
    required this.idPrevious,
    this.nameCompanyPrevious,
    this.countryPrevious,
    this.nameDepartmentPrevious,
    this.nameLeaderPrevious,
    this.phoneLeaderPrevious,
    this.emailLeaderPrevious,
    this.dateTimePrevious,
  }) : super(key: key);

  @override
  State<ManagerDepartmentScreen> createState() =>
      _ManagerDepartmentScreenState();
}

class _ManagerDepartmentScreenState extends State<ManagerDepartmentScreen> {
  Department? itemDepartment;
  Stream<List<Department>>? s;
  @override
  void initState() {
    super.initState();
    s = Provider.of<DepartmentProvider>(
      context,
      listen: false,
    ).getDepartment(widget.idPrevious);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.nameCompanyPrevious != null
                                    ? "Công ty: ${widget.nameCompanyPrevious!}"
                                    : "Phòng ban trực thuộc: ${widget.nameDepartmentPrevious!}",
                                style: const TextStyle(
                                  fontSize: defaultFontsize,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.dateTimePrevious != null
                                    ? "Ngay tao: ${DateFormat.yMMMd().format(widget.dateTimePrevious!)}"
                                    : "Trưởng phòng ban tổng: ${widget.nameLeaderPrevious!}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: defaultFontsize,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.countryPrevious != null
                                    ? "Quốc Gia: ${widget.countryPrevious!}"
                                    : "Email: ${widget.emailLeaderPrevious!}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: defaultFontsize,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Text("Danh sách phòng ban: "),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AddDepartment(
                                          idPrevious: widget.idPrevious,
                                          nameCompanyPrevious:
                                              widget.nameCompanyPrevious,
                                          nameDepartmentPrevious:
                                              widget.nameDepartmentPrevious,
                                          itemAdd: (departmentItem) {
                                            final departmentService =
                                                Provider.of<DepartmentProvider>(
                                              context,
                                              listen: false,
                                            );

                                            departmentService
                                                .addDepartment(departmentItem);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kBlackColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 12.0),
                                      child: Text(
                                        "Thêm phòng ban",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48.0),
                          child: DividerWidget(),
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context)
                              ? size.height * 0.8
                              : size.height * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    StreamBuilder<List<Department>>(
                                        stream: s,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.active &&
                                              snapshot.data != null) {
                                            return ListView.builder(
                                              controller: ScrollController(),
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                final product =
                                                    snapshot.data![index];
                                                return ItemManager(
                                                  itemDepartment: product,
                                                  press3: () {
                                                    setState(() {
                                                      itemDepartment = product;
                                                    });
                                                  },
                                                  press1: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            TabControl(
                                                          itemDepartment:
                                                              product,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  press2: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            TabControl(
                                                          itemDepartment:
                                                              product,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  snapshot.error.toString()),
                                            );
                                          }
                                          // ignore: avoid_print
                                          print(snapshot.data);
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        })

                                    // Consumer<DepartmentService>(
                                    //     builder: ((context, value, child) {
                                    //   return ListView.builder(
                                    //       shrinkWrap: true,
                                    //       itemCount: value
                                    //           .getDepartment(
                                    //               widget.idPrevious)!
                                    //           .length,
                                    //       itemBuilder: (context, index) {
                                    //         return ItemManager(
                                    //           press3: () {
                                    //             setState(() {
                                    //               itemDepartment = value
                                    //                   .getDepartment(widget
                                    //                       .idPrevious)![index];
                                    //             });
                                    //           },
                                    //           itemDepartment:
                                    //               value.getDepartment(widget
                                    //                   .idPrevious)![index],
                                    //           press1: () {
                                    //             Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                 builder: (_) =>
                                    //                     TabControl(
                                    //                   itemDepartment: value
                                    //                       .getDepartment(widget
                                    //                           .idPrevious)![index],
                                    //                 ),
                                    //               ),
                                    //             );
                                    //           },
                                    //           press2: () {
                                    //             Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                   builder:
                                    //                       (_) => TabControl(
                                    //                             itemDepartment:
                                    //                                 value.getDepartment(
                                    //                                     widget
                                    //                                         .idPrevious)![index],
                                    //                           )),
                                    //             );
                                    //           },
                                    //         );
                                    //       });
                                    // }))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: ItemDetailManager(
                      itemDepartmnet: itemDepartment,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
