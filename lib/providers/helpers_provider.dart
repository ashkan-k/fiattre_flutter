
import 'package:flutter/cupertino.dart';

class HelpersProvider extends ChangeNotifier
{
  static LunchUrl(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}