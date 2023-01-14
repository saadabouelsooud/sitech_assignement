
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:si_tech_assignment/core/theme/styles/colors.dart';
import 'package:si_tech_assignment/core/utils/prefrences_util.dart';

class ThemeProvider extends StateNotifier<bool> {

  ThemeProvider() :super(false){
    state = SharedPreferenceUtils.getBool(PrefKeys.isDark) ?? false;
  }
  ThemeData dark = ThemeData(
    primaryColor: Color(0xffab351c),
    // textTheme: TextTheme().apply(bodyColor: Colors.white),
    iconTheme: IconThemeData(color: Colors.black),
    buttonTheme: ButtonThemeData(buttonColor: Color(0xffab351c)),
    scaffoldBackgroundColor: Colors.white,
    accentColor: Color(0xffab351c),
  );

  ThemeData light = ThemeData(
    primaryColor: AppColors.mainColor,
    // textTheme: TextTheme(body1: TextStyle(color: Colors.white).apply()),
    // textTheme: TextTheme().apply(bodyColor: Colors.orange, displayColor: Colors.orange),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black.withOpacity(0)),
    iconTheme: IconThemeData(color: Colors.black),
    buttonTheme: ButtonThemeData(buttonColor: Colors.blueAccent),
    scaffoldBackgroundColor: Colors.white,
    accentColor: AppColors.mainColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: "TeXGyreAdventor-Regular",
        fontSize: 11.181839942932129,
        color: AppColors.mainColor,
      ),
      hintStyle: TextStyle(
        fontFamily: "NeusaNextW00-Regular",
        fontSize: 10.358949661254883,
        color: Color(0xff758091),
      ),
    ),
  );

  get switchTheme {
    state = !state;
    SharedPreferenceUtils.setBool(PrefKeys.isDark, state);
  }
}
