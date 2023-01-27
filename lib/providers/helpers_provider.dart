
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpersProvider extends ChangeNotifier
{
  static LunchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}