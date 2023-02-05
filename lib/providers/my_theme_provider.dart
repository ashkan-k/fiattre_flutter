import 'package:fiatre_app/providers/helpers_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  HelpersProvider helpersProvider = HelpersProvider();

  bool get isDarkMode => themeMode == ThemeMode.dark;

  MyThemeProvider(){
    GetCurrentTheme();
  }

  void SetTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    helpersProvider.RemoveSharedPreference('user_theme_is_dark');
    helpersProvider.SetSharedPreference('user_theme_is_dark', bool, isDarkMode);
    notifyListeners();
  }

  void GetCurrentTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('user_theme_is_dark') == true){
      themeMode = ThemeMode.dark;
    }else{
      themeMode = ThemeMode.light;
    }
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
    unselectedWidgetColor: Color(0xFF585659),
    primaryColorLight: Color(0xFFfd0002),
    scaffoldBackgroundColor: Color(0xFF2f2f31),
    primaryColor: Color(0xFF171516),
    secondaryHeaderColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    bottomAppBarColor: CupertinoColors.systemGrey,
    buttonColor: Color(0xFFfd0002),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
      ),
      accentColor: Color(0xFF242426),
    primaryIconTheme: const IconThemeData(color: Color(0xFF252324)),
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
      bodySmall: GoogleFonts.ubuntu(color: Color(0xFF1a1a1c), fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Color(0xFF1a1a1c), fontSize: 12),
    ),
    unselectedWidgetColor: Colors.grey.shade600,
    primaryColorLight: Colors.grey,
    scaffoldBackgroundColor: Colors.grey,
    primaryColor: Colors.grey.shade800,
    secondaryHeaderColor: Color(0xFF1a1a1c),
    iconTheme: const IconThemeData(color: Color(0xFF1a1a1c), opacity: 0.8),
    bottomAppBarColor: Colors.black45,
    buttonColor: Color(0xFFfd0002),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey,
      ),
    accentColor: Colors.grey.shade600,
    primaryIconTheme: const IconThemeData(color: Color(0xff6a6a6c)),

    // colorScheme: const ColorScheme.light()
  );
}
