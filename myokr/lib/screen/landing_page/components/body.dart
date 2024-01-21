import 'package:flutter/material.dart';

import 'item_body.dart';

class FakeData {
  String icon, text;
  FakeData({required this.icon, required this.text});

  static List<FakeData> fakeData = [
    FakeData(icon: "assets/icons/tick.png", text: "Agile alignment"),
    FakeData(
        icon: "assets/icons/tick.png", text: "Faster adaptation and execution"),
    FakeData(icon: "assets/icons/tick.png", text: "Guided weekly check-ins"),
  ];
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ItemBody(
            title: "Integrate with your favorite apps",
            infotitle:
                "We integrate with Office 365, and many more. You can connect with OKR Software to integrate users, tasks, and also check in your key results within the apps.",
            label: "OKR Management Software",
            infolabel:
                "Bridge your strategy-execution gap using Profit.co OKR Software",
            infolist:
                "Take advantage of this powerful goal-setting framework with benefits like:",
            imagesrc: "assets/images/OKR-management.png",
            labelbutton: "Get a Free Demo",
            press: () {},
            list: FakeData.fakeData,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ItemBody(
            imageleft: false,
            title: "Integrate with your favorite apps",
            infotitle:
                "We integrate with Office 365, and many more. You can connect with OKR Software to integrate users, tasks, and also check in your key results within the apps.",
            label: "OKR Management Software",
            infolabel:
                "Bridge your strategy-execution gap using Profit.co OKR Software",
            infolist:
                "Take advantage of this powerful goal-setting framework with benefits like:",
            imagesrc: "assets/images/OKR-management.png",
            labelbutton: "Get a Free Demo",
            press: () {},
            list: FakeData.fakeData,
          ),
        ),
      ],
    );
  }
}
