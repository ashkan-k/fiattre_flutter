import 'package:fiatre_app/pages/components/ThemeSwitcher.dart';
import 'package:fiatre_app/providers/MyThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyThemeProvider themeProvider = MyThemeProvider();
    Icon theme_switcher_icon = Icon(themeProvider.isDarkMode
        ? CupertinoIcons.sun_max_fill
        : CupertinoIcons.moon_fill);

    return Scaffold(
      appBar: AppBar(
        title: Text('فیاتر'),
        centerTitle: true,
        actions: [ThemeSwitcher()],
        backgroundColor:Theme.of(context).appBarTheme.backgroundColor ,
      ),
      body: Column(
        children: [Container()],
      ),
    );
  }
}
