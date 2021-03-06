import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyles {
  //Colors
  static const Color black = Color(0xff000000);
  static const Color blackSemiTransparent = Color.fromARGB(113, 0, 0, 0);
  static const Color primaryColor = Color(0xff1A59FE);
  static const Color primaryColorSemiTransparent =
      Color.fromARGB(132, 26, 91, 254);
  static const Color whiteSemiTransparent = Color.fromARGB(144, 255, 255, 255);
  static const Color secondaryColor = Color(0xff002EA8);
  static const Color backgroundColor = Color(0xffE3EDF7);
  static const Color formBoxColor = Color(0xffF0EEEE);
  static const Color editButtonColor = Color(0xffFDD549);
  static const Color deleteButtonColor = Color(0xffFE3636);

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
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueGrey);
  static TextStyle get welcomeText => GoogleFonts.getFont('Roboto',
      fontSize: 20, fontWeight: FontWeight.w500, color: black);
  static TextStyle get descriptionTitleText => GoogleFonts.getFont('Roboto',
      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);
  static TextStyle get descriptionText => GoogleFonts.getFont('Roboto',
      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white);
  static TextStyle get detailTitleText => GoogleFonts.getFont('Roboto',
      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
  static TextStyle get detailText => GoogleFonts.getFont('Roboto',
      fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white);
  static TextStyle get cardTitleText => GoogleFonts.getFont('Roboto',
      fontSize: 18, fontWeight: FontWeight.w500, color: black);
  static TextStyle get appointmentText => GoogleFonts.getFont('Roboto',
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);
}
