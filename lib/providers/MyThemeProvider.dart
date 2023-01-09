import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void SetTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.white54, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
    ),
    unselectedWidgetColor: Colors.white70,
    primaryColorLight: Color(0xFFfd0002),
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.grey.shade900,
    secondaryHeaderColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    buttonColor: Color(0xFFfd0002),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
      )
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: Colors.red,
    //   selectionColor: Colors.green,
    //   selectionHandleColor: Colors.blue,
    // )
    // colorScheme: const ColorScheme.dark()
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
    ),
    unselectedWidgetColor: Colors.black,
    primaryColorLight: Colors.grey,
    scaffoldBackgroundColor: Colors.grey,
    primaryColor: Colors.white,
    secondaryHeaderColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
    buttonColor: Color(0xFFfd0002),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey,
      )

    // colorScheme: const ColorScheme.light()
  );
}
