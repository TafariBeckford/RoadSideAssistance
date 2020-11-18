import 'package:RoadSideAssistance/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:RoadSideAssistance/components/icon_content.dart';

class CustomerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            ReusableCard(
              colour: null,
              onPress: () {},
              cardChild: IconContent(
                icon: FontAwesomeIcons.mars,
                label: 'MALE',
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            ReusableCard(
              colour: null,
              onPress: () {},
              cardChild: IconContent(
                icon: FontAwesomeIcons.mars,
                label: 'MALE',
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            ReusableCard(
              colour: null,
              onPress: () {},
              cardChild: IconContent(
                icon: FontAwesomeIcons.mars,
                label: 'MALE',
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            ReusableCard(
              colour: null,
              onPress: () {},
              cardChild: IconContent(
                icon: FontAwesomeIcons.mars,
                label: 'MALE',
              ),
            )
          ],
        )
      ],
    );
  }
}
