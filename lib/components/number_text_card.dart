import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/round_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Constants.dart';

class NumberTextCard extends StatelessWidget {
  final String label;
  final int numberValue;
  final Function plusFunction;
  final Function minusFunction;

  NumberTextCard(
      {this.label, this.numberValue, this.plusFunction, this.minusFunction});

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kActiveCardColor,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: kLabelTextStyle,
          ),
          Text(
            numberValue.toString(),
            style: kNumberTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(
                iconData: FontAwesomeIcons.minus,
                onPressed: minusFunction,
              ),
              SizedBox(
                width: 10.0,
              ),
              RoundIconButton(
                iconData: FontAwesomeIcons.plus,
                onPressed: plusFunction,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
