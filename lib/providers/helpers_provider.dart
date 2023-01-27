
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpersProvider extends ChangeNotifier
{
  static LunchUrl(String url, bool isInApp) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(url, forceSafariVC: isInApp, forceWebView: isInApp, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}