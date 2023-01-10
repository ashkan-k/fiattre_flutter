import 'package:fiatre_app/pages/components/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);

    var height = MediaQuery.of(context).size.height;

    var images = [
      'images/pic0.png',
      'images/pic0.png',
      'images/pic0.png',
      'images/pic0.png',
    ];

    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (height / 3) * 2,
              width: double.infinity,
              child: Stack(
                children: [
                  PageView(
                    controller: pageController,
                    children: [
                      ShowImage(images[0]),
                      ShowImage(images[1]),
                      ShowImage(images[2]),
                      ShowImage(images[3])
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 4,
                        effect: ExpandingDotsEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            spacing: 3,
                            dotColor: Color.fromARGB(255, 106, 49, 49),
                            activeDotColor: Colors.red),
                        onDotClicked: (index) =>
                            pageController.animateToPage(index,
                                duration: Duration(milliseconds: 10),
                                curve: Curves.bounceOut),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.red,
              height: 500,
            )
          ],
        ),
      ),
    );
  }

  Widget ShowImage(String image){
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Image(image: AssetImage(image),fit: BoxFit.fill,));
  }
}
