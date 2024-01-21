import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';
import 'package:myokr/screen/landing_page/components/body.dart';

import '../../../item/constants.dart';

class ItemBody extends StatelessWidget {
  const ItemBody({
    Key? key,
    this.imageleft = true,
    required this.title,
    required this.infotitle,
    required this.imagesrc,
    required this.label,
    required this.infolabel,
    required this.infolist,
    required this.labelbutton,
    required this.press,
    required this.list,
  }) : super(key: key);

  final bool imageleft;
  final String title,
      imagesrc,
      infotitle,
      label,
      infolabel,
      infolist,
      labelbutton;
  final VoidCallback press;
  final List<FakeData> list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? defaultHorizontalPage : 18,
        vertical: defaultPadding,
      ),
      child: Column(
        mainAxisAlignment: Responsive.isMobile(context)
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        crossAxisAlignment: Responsive.isMobile(context)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(height: Responsive.isMobile(context) ? 12 : defaultPadding),
          Text(
            title,
            textAlign: Responsive.isMobile(context)
                ? TextAlign.left
                : TextAlign.center,
            style: TextStyle(
              color: kBlackColor,
              fontSize: Responsive.isMobile(context) ? 28 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              height:
                  Responsive.isMobile(context) || Responsive.isTablet(context)
                      ? 12
                      : defaultPadding),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal:
                    Responsive.isMobile(context) ? 0 : defaultPadding * 3,
                vertical: defaultPadding),
            child: Text(
              infotitle,
              textAlign: Responsive.isMobile(context)
                  ? TextAlign.left
                  : TextAlign.center,
              style: TextStyle(
                color: kBlackColor,
                fontSize:
                    Responsive.isMobile(context) || Responsive.isTablet(context)
                        ? 18
                        : defaultFontsize,
              ),
            ),
          ),
          SizedBox(
              height:
                  Responsive.isMobile(context) || Responsive.isTablet(context)
                      ? 12
                      : defaultPadding * 4),
          Row(
            children: [
              Responsive.isMobile(context)
                  ? const SizedBox(width: 0)
                  : imageleft
                      ? Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Image.asset(
                              imagesrc,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : const SizedBox(width: 0),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                          color: kBlackColor,
                          fontSize: Responsive.isMobile(context) ||
                                  Responsive.isTablet(context)
                              ? 23
                              : 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      infolabel,
                      style: TextStyle(
                          color: kBlackColor,
                          fontSize: Responsive.isMobile(context) ||
                                  Responsive.isTablet(context)
                              ? 18
                              : defaultFontsize,
                          fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      infolist,
                      style: const TextStyle(
                        color: kBlackColor,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Column(
                      children: List.generate(
                          list.length,
                          (index) => ItemListInfoBody(
                              icon: list[index].icon, text: list[index].text)),
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 8.0, bottom: 8.0),
                          child: ElevatedButton(
                            onHover: (value) {},
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shadowColor: kBlackColor,
                              primary: kBlackColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 20.0),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            child: Text(labelbutton),
                          ),
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.arrow_circle_right,
                            color: kBlackColor,
                          ),
                          onPressed: press,
                          onHover: (value) {},
                          label: const Text(
                            "Learn more",
                            style: TextStyle(
                                color: kBlackColor,
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Responsive.isMobile(context)
                  ? const SizedBox(width: 0)
                  : !imageleft
                      ? Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Image.asset(
                              imagesrc,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : const SizedBox(width: 0),
            ],
          )
        ],
      ),
    );
  }
}

class ItemListInfoBody extends StatelessWidget {
  const ItemListInfoBody({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final String icon, text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
          child: Image.asset(
            icon,
            height: 18,
            width: 18,
            fit: BoxFit.fill,
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 18, color: kBlackColor),
        )
      ],
    );
  }
}
