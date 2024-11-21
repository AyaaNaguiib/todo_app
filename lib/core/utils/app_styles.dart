import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class LightAppStyle{
  static TextStyle appBar = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: ColorsManager.white);


  static TextStyle themeLabel = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: ColorsManager.black);

  static TextStyle selectedThemeLabel = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorsManager.blue);


  static TextStyle bottomSheetTitle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blackAccent);


  static TextStyle hint = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorsManager.hint);
  static TextStyle date = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorsManager.black);

  static TextStyle todoTitle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: ColorsManager.blue);

  static TextStyle todoDiscription = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorsManager.black);
  static TextStyle calenderSelectedDate = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blue);
  static TextStyle calenderUnSelectedDate = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: ColorsManager.black);

  static TextStyle hintRegister = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w300,
      color: ColorsManager.fieldBlack);
  static TextStyle title = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: ColorsManager.white);
  static TextStyle buttonText = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue.shade900);
}

class DarkAppStyle{
  static TextStyle appBar = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: ColorsManager.black);


  static TextStyle themeLabel = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: ColorsManager.white);

  static TextStyle selectedThemeLabel = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorsManager.blue);


  static TextStyle bottomSheetTitle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorsManager.white);


  static TextStyle hint = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorsManager.titleAndDescription);

  static TextStyle date = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorsManager.white);

  static TextStyle todoTitle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: ColorsManager.blue);

  static TextStyle todoDiscription = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorsManager.white);
  static TextStyle calenderSelectedDate = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blue);

  static TextStyle calenderUnSelectedDate = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: ColorsManager.white);
}
