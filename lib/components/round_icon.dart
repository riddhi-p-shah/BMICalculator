import 'package:flutter/material.dart';

import '../Constants.dart';



class RoundIconButton extends StatelessWidget {

  final IconData iconData;
  final Function onPressed;
  RoundIconButton({this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 36.0,
        height: 36.0,
      ),
      shape: CircleBorder(),
      fillColor: kFabColor,
      child: Icon(iconData),
    );
  }
}
