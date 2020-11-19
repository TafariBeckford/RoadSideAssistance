import 'package:RoadSideAssistance/constants.dart';
import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/components/ReusableCard.dart';

class CustomerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Tab(
                        icon: Image.asset("assets/icons/flat-tire.png"),
                        text: 'Flat tire',
                      ),
                    ),
                  ),
                ),
                SizedBox(),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/tow-truck.png"),
                      text: 'Towing',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/car-battery.png"),
                      text: 'Battery Dead',
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/engine-oil.png"),
                      text: 'Engine Oil',
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/gas-pump.png"),
                      text: 'Low Fuel',
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/car-service.png"),
                      text: 'Breakdown',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
