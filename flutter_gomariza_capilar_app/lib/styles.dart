import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyles {
  //Colors
  static const Color black = Color(0xff000000);
  static const Color primaryColor = Color(0xff1A59FE);
  static const Color secondaryColor = Color(0xff002EA8);
  static const Color backgroundColor = Color(0xffE3EDF7);
  static const Color formBoxColor = Color(0xffF0EEEE);

  //Padding, margins
  static const bodyPadding = 8.0;
  static const inputPadding = 18.0;
  static const contentPadding = 16.0;
  static const contentMargin = 5.0;

  //TextStyles
  static TextStyle get linkText => GoogleFonts.getFont('Roboto',
      fontSize: 14, fontWeight: FontWeight.w500, color: primaryColor);
  static TextStyle get secondaryText => GoogleFonts.getFont('Roboto',
      fontSize: 14, fontWeight: FontWeight.w500, color: black);
  static TextStyle get subTitleText => GoogleFonts.getFont('Roboto',
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blueGrey);
}
