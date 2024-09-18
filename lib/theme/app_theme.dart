import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/utils/custom_route.dart';

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade200,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      fontSize: 45,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  )),
  useMaterial3: true,
  primaryColor: CustomColors.azul,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(
      color: CustomColors.azul,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontFamily: 'Montserrat',
    ),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 3,
        color: CustomColors.azul,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 2, color: CustomColors.azul),
    ),
    errorStyle: TextStyle(
        color: Color.fromARGB(255, 255, 17, 0),
        fontSize: 12,
        fontWeight: FontWeight.bold),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: CustomColors.amarelo),
    centerTitle: true,
    backgroundColor: CustomColors.azul,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat',
      color: Colors.white,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: CustomPageTransitionsBuilder(),
    TargetPlatform.iOS: CustomPageTransitionsBuilder(),
  }),
);
