import 'package:fiatre_app/providers/MyThemeProvider.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MyThemeProvider themeProvider = MyThemeProvider();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            themeProvider.SetTheme();
          }, icon: themeProvider.isDarkMode ? Icon(Icons.wb_sunny) : Icon(Icons.brightness_2))
        ],
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          Container()
        ],
      ),
    );
  }
}
