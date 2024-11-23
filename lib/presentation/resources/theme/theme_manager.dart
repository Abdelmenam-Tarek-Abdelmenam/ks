import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

part "color_manager.dart";
part "font_manager.dart";

ThemeData lightThemeData = ThemeData(
  appBarTheme: AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(
          color: ColorManager.whiteColor.withOpacity(0.8), size: 28),
      titleTextStyle: GoogleFonts.acme(
          fontWeight: FontWeight.w600,
          color: ColorManager.whiteColor.withOpacity(0.8),
          fontSize: 22),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white.withOpacity(0),
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark)),
  dividerColor: ColorManager.mainBlue.withOpacity(0.4),
  splashFactory: InkRipple.splashFactory,
  scaffoldBackgroundColor: ColorManager.whiteColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorManager.whiteColor,
    foregroundColor: ColorManager.darkGrey,
  ),
  primaryTextTheme: _textTheme(false),
  primaryColor: ColorManager.mainBlue,
  iconTheme:
      IconThemeData(color: ColorManager.whiteColor.withOpacity(0.8), size: 30),
  primaryColorDark: ColorManager.mainBlue,
  primaryColorLight: ColorManager.mainBlue,
  listTileTheme: ListTileThemeData(
    tileColor: ColorManager.whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    textStyle: WidgetStateProperty.all(_textTheme(false).displayMedium),
    foregroundColor: WidgetStateProperty.all(ColorManager.darkWhite),
  )),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(ColorManager.mainBlue),
    fixedSize: WidgetStateProperty.all(const Size(120, 30)),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    )),
    textStyle: WidgetStateProperty.all(_textTheme(false).displayMedium),
    foregroundColor: WidgetStateProperty.all(ColorManager.darkWhite),
  )),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    side: WidgetStateBorderSide.resolveWith((states) =>
        BorderSide(color: Colors.grey.withOpacity(0.4), width: 2.0)),
    foregroundColor: WidgetStateProperty.all(ColorManager.mainBlue),
  )),
  textTheme: _textTheme(false),
  colorScheme: const ColorScheme(
    onSurface: ColorManager.mainBlue, // used
    onSecondary: ColorManager.lightGrey, // used
    onPrimary: ColorManager.whiteColor, // used
    primary: ColorManager.mainBlue,
    secondary: ColorManager.darkGrey, //used
    surface: ColorManager.lightBlue,
    error: ColorManager.darkRed,
    onError: ColorManager.lightRed,
    brightness: Brightness.light,
  ),
);

ThemeData darkThemeData = ThemeData(
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light)),
  dividerColor: ColorManager.mainBlue.withOpacity(0.5),
  splashFactory: InkRipple.splashFactory,
  scaffoldBackgroundColor: Colors.transparent,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorManager.whiteColor,
    foregroundColor: ColorManager.darkGrey,
  ),
  primaryTextTheme: _textTheme(true),
  primaryColor: ColorManager.mainBlue,
  iconTheme: const IconThemeData(color: ColorManager.whiteColor, size: 30),
  primaryColorDark: ColorManager.mainBlue,
  primaryColorLight: ColorManager.mainBlue,
  listTileTheme: ListTileThemeData(
    tileColor: ColorManager.whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(ColorManager.mainBlue),
    fixedSize: WidgetStateProperty.all(const Size(120, 30)),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )),
    textStyle: WidgetStateProperty.all(_textTheme(true).labelLarge),
    foregroundColor: WidgetStateProperty.all(ColorManager.darkWhite),
  )),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    side: WidgetStateBorderSide.resolveWith((states) =>
        BorderSide(color: Colors.grey.withOpacity(0.4), width: 2.0)),
    foregroundColor: WidgetStateProperty.all(ColorManager.mainBlue),
  )),
  textTheme: _textTheme(true),
  colorScheme: const ColorScheme(
    background: ColorManager.lightBlue,
    onSurface: ColorManager.mainBlue,
    onBackground: ColorManager.lightBlue,
    onSecondary: ColorManager.whiteColor,
    onPrimary: ColorManager.mainBlue,
    primary: ColorManager.mainBlue,
    secondary: ColorManager.lightGrey,
    surface: ColorManager.darkWhite,
    error: ColorManager.whiteColor,
    onError: ColorManager.mainBlue,
    brightness: Brightness.light,
  ),
);
