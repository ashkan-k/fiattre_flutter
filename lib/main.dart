import 'package:fiatre_app/pages/layouts/main_wrapper.dart';
import 'package:fiatre_app/providers/category_data_provider.dart';
import 'package:fiatre_app/providers/episode_data_provider.dart';
import 'package:fiatre_app/providers/my_theme_provider.dart';
import 'package:fiatre_app/providers/poster_data_provider.dart';
import 'package:fiatre_app/providers/slider_data_provider.dart';
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

  //Check and Set Current Theme
  MyThemeProvider themeProvider = MyThemeProvider();
  themeProvider.CheckCurrentTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyThemeProvider()),
        ChangeNotifierProvider(create: (context) => CategoryDataProvider()),
        ChangeNotifierProvider(create: (context) => PosterDataProvider()),
        ChangeNotifierProvider(create: (context) => SliderDataProvider()),
        ChangeNotifierProvider(create: (context) => EpisodeDataProvider()),
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
            Locale('en', 'EN'), // English, no country code
            Locale('fa', 'IR'), // Persian, no country code
          ],
          locale: Locale('en', 'EN'),
          debugShowCheckedModeBanner: false,
          title: 'فیاتر',
          home: MainWrapper(),
        );
      },
    );
  }
}
