import 'package:flutter/material.dart';
import 'package:myokr/provider/menu_provider.dart';
import 'package:myokr/screen/landing_page/components/side_menu.dart';
import 'package:provider/provider.dart';
import '../../item/constants.dart';
import 'components/body.dart';
import 'components/footer.dart';
import 'components/header.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);
  static String routename = "/";

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        key: menu.scaffoldkey,
        drawer: const SideMenu(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kGreenLightColor,
          child: const Icon(Icons.navigation),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              Header(),
              Body(),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
