import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

class HelpersProvider extends ChangeNotifier {
  dynamic data;

  static LunchUrl(String url, bool isInApp) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(url,
          forceSafariVC: isInApp,
          forceWebView: isInApp,
          enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Widget ShowImageClipRRect(String image, String type, double border) {
    if (type == 'asset') {
      return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(border)),
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.fill,
          ));
    }

    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(border)),
        child: Image(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ));
  }

  static String ParseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  void SetSharedPreference(String name, type, var value) async {
    final prefs = await SharedPreferences.getInstance();

    switch (type) {
      case String:
        await prefs.setString(name, value);
        break;
      case int:
        await prefs.setInt(name, value);
        break;
      case bool:
        await prefs.setBool(name, value);
        break;
      case double:
        await prefs.setDouble(name, value);
        break;
      case List:
        await prefs.setStringList(name, value);
        break;
    }

    this.data = value;
  }

  void GetSharedPreference(String name, type) async {
    final prefs = await SharedPreferences.getInstance();

    switch (type) {
      case String:
        this.data = prefs.getString(name);
        break;
      case int:
        this.data = prefs.getInt(name);
        break;
      case bool:
        this.data = prefs.getBool(name);
        break;
      case double:
        this.data = prefs.getDouble(name);
        break;
      case List:
        this.data = prefs.getStringList(name);
        break;
    }
  }

  Future<bool> RemoveSharedPreference(String name) async {
    final prefs = await SharedPreferences.getInstance();
    bool resutl = await prefs.remove(name);

    return resutl;
  }
}
