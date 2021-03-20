import 'package:flutter/material.dart';
import 'package:team_at/helper/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final Function validator;
  final Function onSave;
  final bool obscureText;
  final bool filled;
  final TextInputType keyboardType;
  final String hintText;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final Color fillColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color cursorColor;
  final double borderWidth;
  final double borderRadius;
  final bool withSuffixIcon;
  final double fieldWidth ;
  final double fieldHeight ;

  CustomTextFormField(
      {this.withSuffixIcon = false,
        @required this.validator,
        @required this.onSave,
        this.obscureText = false,
        this.keyboardType = TextInputType.text,
        @required this.hintText,
        @required this.prefixIcon,
        this.filled = false,
        this.prefixIconColor = Colors.black,
        this.fillColor = Colors.white,
        this.focusedBorderColor = kMainColor,
        this.borderColor = Colors.black,
        this.cursorColor = Colors.black,
        this.borderWidth = 2.0,
        this.borderRadius = 20.0,
        this.fieldWidth = 375 ,
        this.fieldHeight = 60 ,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fieldWidth,
      height: fieldHeight,
      child: TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: onSave,
        obscureText: obscureText,
        keyboardType: keyboardType,
        cursorColor: cursorColor,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20.h),
            isDense: true,
            hintText: hintText,
            suffixIcon: withSuffixIcon
                ? Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff757575),
            )
                : Container(
              width: 0,
              height: 0,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: prefixIconColor,
            ),
            errorStyle: TextStyle(fontSize: 10.sp , fontFamily: "Cairo"),
            filled: filled,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: borderWidth,
              ),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedBorderColor,
                width: borderWidth,
              ),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: borderWidth,
              ),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            )
        ),
      ),
    );
  }
}