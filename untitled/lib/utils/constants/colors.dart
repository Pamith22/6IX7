import 'package:flutter/material.dart';

class TColors {
  TColors._();

  //app basic colors

  static const Color primary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF000000);
  static const Color accent = Color(0xFF4F4F4F);


  //text colors

  static const Color textprimary = Color(0xFF000000);
  static const Color textsecondary = Color(0xFFFFFFFF);
  static const Color textWhite = Colors.white;

  //background colors

  static const Color light = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF000000);
  static const Color primaryBackground = Color(0xFFE4E4E4);
  static const Color secondaryBackground = Color(0xFFFFDF00);

  // background container colors

  static const Color lightcontainer = Color(0xFFF6F6F6);
  static Color darkcontainer = TColors.textWhite.withOpacity(0.1);

  //Border colors

  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // error and validation colors

  static const Color error = Color(0xFFD32F2F);
  static const Color sucess = Color(0xFF388E3C);
  static const Color warning = Color(0xFFf57C00);
  static const Color info = Color(0xFF1976D2);

  //neutral shades

  static const Color black = Color(0xFF232323);
  static const Color darkerGray = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
}










