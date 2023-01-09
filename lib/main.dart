import 'package:fiatre_app/pages/layouts/base_page.dart';
import 'package:fiatre_app/providers/MyThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  // Disable orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyThemeProvider()),
      ],
      child: const FiatreApp(),
    )
  );
}

class FiatreApp extends StatelessWidget {
  const FiatreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeProvider>(
      builder: (context, my_theme_provider, child) {
        return MaterialApp(
          themeMode: my_theme_provider.themeMode,
          darkTheme: MyThemes.darkTheme,
          theme: MyThemes.lightTheme,
          localizationsDelegates: const [
            // AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('fa', ''), // Persian, no country code
          ],
          locale: Locale('en', ''),
          debugShowCheckedModeBanner: false,
          title: 'فیاتر',
          home: BasePage(),
        );
      },
    );
  }
}
