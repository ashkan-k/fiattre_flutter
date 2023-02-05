import 'package:flutter/material.dart';
import 'package:fiatre_app/pages/components/theme_switcher.dart';
import 'package:fiatre_app/providers/my_theme_provider.dart';
import 'package:flutter/cupertino.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();
  bool showThemeSwitcher = false;

  MyAppBar(this.showThemeSwitcher);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 38,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('خرید اشتراک',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).iconTheme.color)),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Theme.of(context).buttonColor),
                ),
              ),
            ),

            Center(
              child: showThemeSwitcher ? ThemeSwitcher() : Container(),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('فیاتر',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
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
