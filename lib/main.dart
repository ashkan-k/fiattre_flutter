import 'package:fiatre_app/pages/layouts/base_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FiatreApp());
}

class FiatreApp extends StatelessWidget {
  const FiatreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeProvider>(
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'فیاتر',
        home: BasePage(),
      ),
    );
  }
}
