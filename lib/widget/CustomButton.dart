import 'package:flutter/material.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/widget/custom_text.dart';

class CustomButton extends StatelessWidget {
  final double buttonWidth  ;
  final double buttonHeight  ;
  final double buttonRadius  ;
  final Function onClick ;
  final String text ;
  final double buttonFontSize ;


  CustomButton({this.buttonWidth, this.buttonHeight, this.buttonRadius , this.onClick , this.text , this.buttonFontSize = 16});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kMainColor,
              kSecondColor,
            ],
          ),
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: CustomText(
          text: text,
          fontColor: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: buttonFontSize,

        ),
      ),
    );
  }
}
