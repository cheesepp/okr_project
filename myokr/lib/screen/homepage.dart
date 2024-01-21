import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myokr/item/icon_item.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/model/firebase/user_model.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/firebase/user_provider.dart';
import 'package:myokr/provider/my_widget_provider.dart';
import 'package:myokr/screen/menu/custom_menu.dart';
import 'package:myokr/screen/menu/main_menu.dart';
import 'package:myokr/screen/menu/sub_menu.dart';
import 'package:myokr/service/add_period.dart';
import 'package:myokr/service/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> mainMenu = ['My OKR', 'Company'];
  List<List<String>> subMenu = [
    ['My Okr', 'Add Okr'],
    []
  ];
  bool menu = false;
  double width = 0;
  double xOffset = 0;
  String selectWidget = '0-0';
  UserData? userModel;
  String? id;
  String? email;
  UserStatus? userStatus;
  @override
  void initState() {
    super.initState();
    // createPeriod();
    // context.read<UserProvider>().setStatus(UserStatus.loading);
    context.read<ObjectivesProvider>().setStatus(ObjectivesStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 606) {
      width = MediaQuery.of(context).size.width - 50;
    } else {
      width = 300;
    }
    id = context.watch<User?>()!.uid;
    email = context.watch<User?>()!.email;
    context.read<MyWidgetProvider>().setUserID(id!);
    // if (id != null) {
    //   context.watch<UserProvider>().loadUser(id!);
    //   userModel = context.watch<UserProvider>().userInfo;
    // }
    return Consumer<MyWidgetProvider>(
        builder: (context, myWidget, child) => SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    menu
                        ? Container(
                            width: width,
                            // color: const Color.fromARGB(255, 59, 56, 56),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0,
                                color: const Color.fromARGB(255, 136, 136, 136),
                              ),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 82, 82, 82),
                                    Color.fromARGB(255, 231, 231, 231)
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight),
                            ),
                            child: ListView(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 136, 136, 136),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight:
                                                  Radius.circular(20))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            const CircleAvatar(
                                              radius: 50,
                                              backgroundImage: AssetImage(
                                                  'assets/images/login.png'),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            getTittleTextBlack(email!, 20)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 20),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => MainMenu(
                                        tittle: mainMenu[index],
                                        submenu: subMenu[index],
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (context, indexs) =>
                                                SubMenu(
                                                  color: '$index-$indexs' ==
                                                          context
                                                              .read<
                                                                  MyWidgetProvider>()
                                                              .getRoutePage
                                                      ? const Color.fromARGB(
                                                          255, 255, 255, 255)
                                                      : Colors.black,
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            MyWidgetProvider>()
                                                        .changePage(
                                                            '$index-$indexs');
                                                    context
                                                        .read<
                                                            ObjectivesProvider>()
                                                        .setStatus(
                                                            ObjectivesStatus
                                                                .loading);
                                                    context
                                                        .read<
                                                            MyWidgetProvider>()
                                                        .setChangeWidget(false);
                                                    context
                                                        .read<ResultProvider>()
                                                        .resultList
                                                        .clear();
                                                  },
                                                  tittle: subMenu[index]
                                                      [indexs],
                                                ),
                                            itemCount: subMenu[index].length)),
                                    itemCount: mainMenu.length,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<FirebaseAuthMethods>()
                                        .signOut(context);
                                  },
                                  child: Center(
                                    child: Container(
                                        width: 200,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            color: const Color.fromARGB(
                                                255, 82, 82, 82)),
                                        child: const Center(
                                            child: Text(
                                          'Logout',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(
                        width: 0,
                        color: Color.fromARGB(255, 136, 136, 136),
                      ))),
                      width: 40,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  menu = !menu;
                                });
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: buttonMenu()),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: context.read<MyWidgetProvider>().getPage,
                    )
                  ],
                ),
              ),
            ));
  }

  ClipPath buttonMenu() {
    return ClipPath(
      clipper: CustomMenuClipper(),
      child: Container(
        color: const Color.fromARGB(255, 136, 136, 136),
        height: 120,
        width: 40,
        child: menu
            ? getIconBlack(Icons.keyboard_double_arrow_left_sharp, 20)
            : getIconBlack(Icons.keyboard_double_arrow_right_sharp, 20),
      ),
    );
  }
}
