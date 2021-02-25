import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/viewModel/app_langauge_viewModel.dart';

class CustomText extends StatelessWidget {
 final String text ;
 final Color fontColor ;
 final double fontSize ;
 final FontWeight fontWeight ;
 final Alignment textAlignment;

 CustomText(
      {@required this.text,
      this.fontColor  = Colors.black,
      this.fontSize   = 16,
      this.fontWeight = FontWeight.normal,
      this.textAlignment = Alignment.center
      });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLanguageViewModel>(
      init: AppLanguageViewModel() ,
      builder: (controller) => Container(
        padding: EdgeInsets.all(0),
        alignment: (textAlignment == Alignment.center) ? textAlignment : (controller.currentAppLanguage== "ar" ? Alignment.centerRight : Alignment.centerLeft ),
        child: Text(
          text,
          //overflow: TextOverflow.fade,
          softWrap: true,
          style: TextStyle(
            color: fontColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontFamily: "Poppins"
          ),
        ),
      ),
    );
  }
}
