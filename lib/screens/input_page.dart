import 'package:bmi_calculator/Constants.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/number_text_card.dart';
import 'package:bmi_calculator/screens/result_page.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;

  Color maleColor = kInactiveCardColor;
  Color femaleColor = kInactiveCardColor;
  Color selectedColor;
  int height = 180;
  int weight = 50;
  int age = 25;

  void updateColour(Gender selectedGender) {
    if (selectedGender == Gender.male) {
      if (maleColor == kInactiveCardColor) {
        maleColor = kActiveCardColor;
        femaleColor = kInactiveCardColor;
      } else {
        maleColor = kInactiveCardColor;
        femaleColor = kActiveCardColor;
      }
    }

    if (selectedGender == Gender.female) {
      if (femaleColor == kInactiveCardColor) {
        femaleColor = kActiveCardColor;
        maleColor = kInactiveCardColor;
      } else {
        femaleColor = kInactiveCardColor;
        maleColor = kActiveCardColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GenderCard(
                      genderName: "MALE",
                      genderOfTheCard: Gender.male,
                      genderIcon: FontAwesomeIcons.mars,
                      selectedGender: this.selectedGender,
                      onSelectTheGender: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GenderCard(
                      genderName: "FEMALE",
                      genderOfTheCard: Gender.female,
                      genderIcon: FontAwesomeIcons.venus,
                      selectedGender: this.selectedGender,
                      onSelectTheGender: () {
                        setState(() {
                          selectedGender = Gender.female;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: ksliderInactiveColor,
                        activeTrackColor: Colors.white,
                        thumbColor: kBottomContainerColor,
                        overlayColor: kSliderThemOverlayColor,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 20.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: kMinHeight,
                        max: kMaxHeight,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.toInt();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: NumberTextCard(
                      label: 'WEIGHT',
                      numberValue: weight.toInt(),
                      plusFunction: () {
                        setState(() {
                          weight++;
                        });
                      },
                      minusFunction: () {
                        setState(() {
                          weight--;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: NumberTextCard(
                      label: 'Age',
                      numberValue: age,
                      plusFunction: () {
                        setState(() {
                          age++;
                        });
                      },
                      minusFunction: () {
                        setState(() {
                          age--;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              buttonText: 'CALCULATE',
              onTap: () {
                CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);


                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResultPage(
                      bmiResult: calc.calculateBMI(),
                      resultText: calc.getResult(),
                      interpretation: calc.getInterpretation(),
                    )));
              },
            )
          ],
        ));
  }
}

class GenderCard extends StatelessWidget {
  final String genderName;
  final IconData genderIcon;
  final Gender genderOfTheCard;
  final Gender selectedGender;
  final Function onSelectTheGender;

  GenderCard(
      {this.genderName,
      this.genderIcon,
      this.genderOfTheCard,
      this.selectedGender,
      this.onSelectTheGender});

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      onPress: onSelectTheGender,
      colour: selectedGender == genderOfTheCard
          ? kActiveCardColor
          : kInactiveCardColor,
      cardChild: IconContent(
        iconData: genderIcon,
        label: genderName,
      ),
    );
  }
}
