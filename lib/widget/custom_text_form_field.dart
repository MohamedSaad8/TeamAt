import 'package:flutter/material.dart';
import 'package:team_at/helper/constant.dart';

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
      this.borderRadius = 20.0});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSave,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      decoration: InputDecoration(
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
      ),
    );
  }
}
