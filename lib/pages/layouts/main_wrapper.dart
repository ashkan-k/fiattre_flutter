import 'package:fiatre_app/config/my_flutter_app_icons.dart';
import 'package:fiatre_app/pages/components/my_app_bar.dart';
import 'package:fiatre_app/pages/home_page.dart';
import 'package:fiatre_app/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentPageIndex = 0;


  static const List<String> bottom_app_bar_names = [
    'خانه',
    'دسته بندی',
    'بازی و سرگرمی',
    'جستجو',
    'حساب من',
  ];

  List<IconData> bottom_app_bar_icons = [
    Icons.home_outlined,
    Icons.add_business_outlined,
    FontAwesomeIcons.gamepad,
    Icons.search_outlined,
    Icons.person_outline
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomBarPageTransition(
        builder: (_, index) => _getBody(index),
        currentIndex: _currentPageIndex,
        totalLength: bottom_app_bar_names.length,
      ),
      bottomNavigationBar: _getBottomBar(),
    );
  }

  Widget _getBody(int index) {
    Widget currentPage;

    switch(index){
      case 0:
        currentPage = HomePage();
        break;
      case 1:
        currentPage = TestPage();
        break;
      default:
        currentPage = HomePage();
        break;
    }

    return CustomScrollView(
      //key:_keys[index] //add keys to avoid initiate child widget after animation ends
      slivers: <Widget>[
        SliverFillRemaining(
          child: currentPage,
        ),
      ],
    );
  }

  Widget _getBottomBar() {
    return Directionality(textDirection: TextDirection.rtl, child: BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryIconTheme.color,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _currentPageIndex = index;
          setState(() {});
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
            bottom_app_bar_names.length,
                (index) => BottomNavigationBarItem(
                icon: Icon(bottom_app_bar_icons[index]),
                label: bottom_app_bar_names[index]
            ))));
  }
}
