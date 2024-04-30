import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextStyles {

  TextStyle getStyle(int type) {
    Color color= Colors.black;
    double fontSize= 16;
    FontWeight fontWeight= FontWeight.normal;
    TextDecoration? textDecoration;
    switch(type) {
      case 1: {
        color= Colors.black;
        fontSize= 14;
      }
      case 2: {
        color= Colors.white;
        fontSize= 16;
      }
      case 3: {
        color= Colors.orange;
        fontSize= 13;
      }
      default: {
        color= Colors.black;
        fontSize= 14;
      }
    }
    return GoogleFonts.dosis(
      textStyle: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationThickness: 1.2,
      )
    );
  }
}