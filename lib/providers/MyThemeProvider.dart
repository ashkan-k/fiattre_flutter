
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void SetTheme(){
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyThemes {

  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.white54, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),

    ),
    unselectedWidgetColor: Colors.white70,
    primaryColorLight: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.deepOrange,
    secondaryHeaderColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.deepOrange),
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: Colors.red,
    //   selectionColor: Colors.green,
    //   selectionHandleColor: Colors.blue,
    // )
    // colorScheme: const ColorScheme.dark()
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
    ),
    unselectedWidgetColor: Colors.black,
    primaryColorLight: Colors.grey,
    scaffoldBackgroundColor: Colors.grey,
    primaryColor: Colors.white,
    secondaryHeaderColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white , opacity: 0.8),

    // colorScheme: const ColorScheme.light()
  );

}