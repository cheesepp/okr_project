import 'package:flutter/material.dart';
import 'package:myokr/provider/my_widget_provider.dart';
import 'package:provider/provider.dart';

import '../../item/constants.dart';
import '../../item/divider.dart';
import '../../item/item_detail_manager.dart';
import '../../item/item_manager.dart';
import '../../item/responsive.dart';
import '../../model/firebase/company_mode.dart';
import '../../provider/firebase/company_provider.dart';
import 'components/add_company.dart';
import '../../item/tab_control.dart';

class ManagerCompanyScreen extends StatefulWidget {
  final String userID;
  const ManagerCompanyScreen({Key? key, required this.userID})
      : super(key: key);
  static const routeName = '/company-manager';
  @override
  State<ManagerCompanyScreen> createState() => _ManagerCompanyScreenState();
}

class _ManagerCompanyScreenState extends State<ManagerCompanyScreen> {
  Company? itemCompany;
  Stream<List<Company>>? s;
  @override
  void initState() {
    super.initState();
    s = Provider.of<CompanyProvider>(
      context,
      listen: false,
    ).getCompany(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
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
                        children: [
                          Row(
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AddCompany(
                                            userID: widget.userID,
                                            itemAdd: (companyItem) {
                                              final companyService =
                                                  Provider.of<CompanyProvider>(
                                                context,
                                                listen: false,
                                              );
                                              companyService
                                                  .addCompany(companyItem);
                                            },
                                          );
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kBlackColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 12.0),
                                      child: Text(
                                        "Thêm công ty",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 48.0, vertical: 24.0),
                            child: DividerWidget(),
                          ),
                          SizedBox(
                            height: Responsive.isMobile(context)
                                ? size.height * 0.8
                                : size.height * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      StreamBuilder<List<Company>>(
                                          stream: s,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.active &&
                                                snapshot.data != null) {
                                              return ListView.builder(
                                                controller: ScrollController(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  final product =
                                                      snapshot.data![index];
                                                  return ItemManager(
                                                    itemCompany: product,
                                                    press3: () {
                                                      setState(() {
                                                        itemCompany = product;
                                                      });
                                                    },
                                                    press1: () async {
                                                      context
                                                          .read<
                                                              MyWidgetProvider>()
                                                          .setCompany(product);
                                                      context
                                                          .read<
                                                              MyWidgetProvider>()
                                                          .changePage('1-1');

                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder: (_) =>
                                                      //         TabControl(
                                                      //       itemCompany:
                                                      //           product,
                                                      //     ),
                                                      //   ),
                                                      // );
                                                    },
                                                    press2: () {
                                                      context
                                                          .read<
                                                              MyWidgetProvider>()
                                                          .setCompany(product);
                                                      context
                                                          .read<
                                                              MyWidgetProvider>()
                                                          .changePage('1-1');

                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder: (_) =>
                                                      //         TabControl(
                                                      //       itemCompany:
                                                      //           product,
                                                      //     ),
                                                      //   ),
                                                      // );
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
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          })

                                      // Consumer<CompanyProvider>(
                                      //     builder: ((context, value, child) {
                                      //   return ListView.builder(
                                      //       controller: ScrollController(),
                                      //       shrinkWrap: true,
                                      //       itemCount: value.getCompany()
                                      //       itemBuilder: ((context, index) {
                                      //         return ItemManager(
                                      //           itemCompany: value.items[index],
                                      //           press3: () {
                                      //             setState(() {
                                      //               itemCompany =
                                      //                   value.items[index];
                                      //             });
                                      //           },
                                      //           press1: () {
                                      //             Navigator.push(
                                      //               context,
                                      //               MaterialPageRoute(
                                      //                 builder: (_) =>
                                      //                     TabControl(
                                      //                   itemCompany:
                                      //                       value.items[index],
                                      //                 ),
                                      //               ),
                                      //             );
                                      //           },
                                      //           press2: () {
                                      //             Navigator.push(
                                      //               context,
                                      //               MaterialPageRoute(
                                      //                   builder: (_) =>
                                      //                       TabControl(
                                      //                         itemCompany: value
                                      //                             .items[index],
                                      //                       )),
                                      //             );
                                      //           },
                                      //         );
                                      //       }));
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
                        itemCompany: itemCompany,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
