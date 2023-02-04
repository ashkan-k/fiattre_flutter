import 'package:fiatre_app/pages/components/my_app_bar.dart';
import 'package:fiatre_app/pages/home_page.dart';
import 'package:fiatre_app/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';

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
  static const int totalPage = 4;

  List<IconData> bottom_app_bar_icons = [
    Icons.home_outlined,
    Icons.add_business_outlined,
    Icons.game,
    Icons.multiline_chart
  ];

  List icons = [
    Icons.home,
    Icons.telegram,
    Icons.support,
    Icons.watch,
  ];

  List names = [
    'خانه',
    'تماس با ما',
    'تلگرام',
    'واتساپ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomBarPageTransition(
        builder: (_, index) => _getBody(index),
        currentIndex: _currentPageIndex,
        totalLength: totalPage,
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
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _currentPageIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
            totalPage,
                (index) => BottomNavigationBarItem(
                icon: Icon(icons[index]),
                label: names[index]
            ))));
  }
}
