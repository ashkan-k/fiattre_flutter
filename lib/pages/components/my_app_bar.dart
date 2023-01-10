import 'package:flutter/material.dart';
import 'package:fiatre_app/pages/components/theme_switcher.dart';
import 'package:fiatre_app/providers/my_theme_provider.dart';
import 'package:flutter/cupertino.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    MyThemeProvider themeProvider = MyThemeProvider();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('خرید اشتراک',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).iconTheme.color)),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Theme.of(context).buttonColor),
              ),
            ),

            Center(
              child: ThemeSwitcher(),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('فیاتر',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).iconTheme.color)),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Theme.of(context).buttonColor),
              ),
            ),
          ],
        ),
        // centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
