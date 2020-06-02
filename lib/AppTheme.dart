import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Name
  static String appName = "Pinoy recipes";

  // Material Design Color
  static Color primaryColor = HexColor('#4dd0e1');
  static Color lightAccent = HexColor('#ec407a');
  static Color lightBackground = Color(0xfffcfcff);

  static Color darkPrimary = Colors.black;
  static Color darkAccent = Color(0xFF3B72FF);
  static Color darkBackground = Colors.black;

  static Color grey = Color(0xff707070);
  static Color textPrimary = Color(0xFF486581);
  static Color textDark = Color(0xFF102A43);

  static Color backgroundColor = Color(0xFFF5F5F7);

  // Grey
  static Color lighGray = HexColor('#f9f9f9');

  // Green
  static Color darkGreen = Color(0xFF3ABD6F);
  static Color lightGreen = Color(0xFFA1ECBF);

  // Yellow
  static Color darkYellow = Color(0xFF3ABD6F);
  static Color lightYellow = Color(0xFFFFDA7A);

  // Blue
  static Color darkBlue = Color(0xFF3B72FF);
  static Color lightBlue = Color(0xFF3EC6FF);

  // Orange
  static Color darkOrange = Color(0xFFFFB74D);

  //text color
  static Color textColor = Colors.black54.withOpacity(.65);

  static ThemeData lighTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: lightBackground,
      primaryColor: primaryColor,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBackground,
      textTheme:
          GoogleFonts.robotoCondensedTextTheme(Theme.of(context).textTheme),

      //  textTheme:
      //     GoogleFonts.cedarvilleCursiveTextTheme(Theme.of(context).textTheme),
      appBarTheme: AppBarTheme(
        textTheme:
            GoogleFonts.robotoCondensedTextTheme(Theme.of(context).textTheme),
        iconTheme: IconThemeData(
          color: lightAccent,
        ),
      ),
    );
  }

  static double headerHeight = 228.5;
  static double paddingSide = 30.0;
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
