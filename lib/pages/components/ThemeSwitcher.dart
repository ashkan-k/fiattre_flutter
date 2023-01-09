import 'package:fiatre_app/providers/MyThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final my_theme_provider = Provider.of<MyThemeProvider>(context);
    Icon theme_switcher_icon = Icon(my_theme_provider.isDarkMode ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill);

    return IconButton(
        onPressed: (){
      my_theme_provider.SetTheme();
    }, icon: theme_switcher_icon);
  }
}
