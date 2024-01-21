import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';

import 'fake_data.dart';

class InfoFooter extends StatelessWidget {
  const InfoFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: ViewMobile(),
      desktop: ViewWebAndTablet(),
    );
  }
}

class ViewWebAndTablet extends StatelessWidget {
  const ViewWebAndTablet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [FakeData(), FakeData(), FakeData()],
    );
  }
}

class ViewMobile extends StatelessWidget {
  const ViewMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [FakeData(), FakeData(), FakeData()],
    );
  }
}
