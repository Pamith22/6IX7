import 'package:flutter/material.dart';
import 'package:untitled/utils/theme/custom_themes/appbar_theme.dart';
import 'package:untitled/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:untitled/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:untitled/utils/theme/custom_themes/chip_theme.dart';
import 'package:untitled/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:untitled/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:untitled/utils/theme/custom_themes/text_field_theme.dart';
import 'package:untitled/utils/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'poppins',
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TTextTheme.lightTextTheme,
  elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
  chipTheme: TChipTheme.lightChipTheme,
  outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
  appBarTheme: TAppBarTheme.lightAppBarTheme,
  bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
  inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );



  static ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'poppins',
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TTextTheme.darkTextTheme,
  elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    chipTheme: TChipTheme.darkChipTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,


  );
}