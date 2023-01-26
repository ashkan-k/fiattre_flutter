import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:fiatre_app/api/models/categories_model.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';
import 'package:fiatre_app/api/services/episode_api_service.dart';
import 'package:fiatre_app/pages/components/my_app_bar.dart';
import 'package:fiatre_app/providers/episode_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final episodeDataProvider =
        Provider.of<EpisodeDataProvider>(context, listen: false);
    episodeDataProvider.GetAllCategoriesWithEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final episodeDataProvider = Provider.of<EpisodeDataProvider>(context);
    final baseApiService = BaseApiService();

    var images = [
      'images/pic0.png',
      'images/pic0.png',
      'images/pic0.png',
      'images/pic0.png',
    ];

    var best_items_images = [
      [
        'https://fiatre.ir/uploads/categories/%DA%A9%D8%A7%D8%B1%DA%AF%D8%B1%D8%AF%D8%A7%D9%86%DB%8C-%D8%AA%D8%A6%D8%A7%D8%AA%D8%B1/1669050910.794893-t0mUwbnkc8os-theatre_directing.jpg',
        'images/best_items_images/1.jpg',
      ],
      [
        'https://fiatre.ir/uploads/categories/%DA%A9%D8%A7%D8%B1%DA%AF%D8%B1%D8%AF%D8%A7%D9%86%DB%8C-%D8%AA%D8%A6%D8%A7%D8%AA%D8%B1/1669050910.794893-t0mUwbnkc8os-theatre_directing.jpg',
        'images/best_items_images/2.jpg',
      ],
      [
        'https://fiatre.ir/uploads/categories/%DA%A9%D8%A7%D8%B1%DA%AF%D8%B1%D8%AF%D8%A7%D9%86%DB%8C-%D8%AA%D8%A6%D8%A7%D8%AA%D8%B1/1669050910.794893-t0mUwbnkc8os-theatre_directing.jpg',
        'images/best_items_images/3.jpg',
      ],
      [
        'https://fiatre.ir/uploads/categories/%DA%A9%D8%A7%D8%B1%DA%AF%D8%B1%D8%AF%D8%A7%D9%86%DB%8C-%D8%AA%D8%A6%D8%A7%D8%AA%D8%B1/1669050910.794893-t0mUwbnkc8os-theatre_directing.jpg',
        'images/best_items_images/4.jpg',
      ],
    ];

    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.70,
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
                            dotColor: (Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.color)!,
                            activeDotColor:
                                Theme.of(context).secondaryHeaderColor),
                        onDotClicked: (index) => pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 10),
                            curve: Curves.bounceOut),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text('برترین ها',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Theme.of(context).iconTheme.color)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(best_items_images![0][1].toString(), fit: BoxFit.fill, width: 190),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                  'فیلم تئاتر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .iconTheme
                                          .color)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(best_items_images![1][1].toString(), fit: BoxFit.fill, width: 190),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                  'مستند تئاتر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .iconTheme
                                          .color)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(best_items_images![0][1].toString(), fit: BoxFit.fill, width: 190),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                  'کار در تئاتر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .iconTheme
                                          .color)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(best_items_images![1][1].toString(), fit: BoxFit.fill, width: 190),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                  'اکتورز استودیو',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .iconTheme
                                          .color)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      print('go to all this category episodes');

                      episodeDataProvider.GetAllCategoriesWithEpisodes();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,
                            color: Theme.of(context).buttonColor),
                        Icon(Icons.circle,
                            size: 10, color: Theme.of(context).buttonColor),
                        SizedBox(width: 15),
                        Text('مشاهده همه',
                            style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).buttonColor)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text('محبوب ترین ها',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Theme.of(context).iconTheme.color)),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 260,
                child: Consumer<EpisodeDataProvider>(
                  builder: (context, episodes_data_provider, child) {
                    switch (episodes_data_provider.state.status) {
                      case Status.LOADING:
                        return Center(
                          child: JumpingDotsProgressIndicator(
                            color: Colors.black,
                            fontSize: 80,
                            dotSpacing: 3,
                          ),
                        );
                      case Status.COMPLETED:
                        List<CategoriesModel>? model = episodes_data_provider
                            .data as List<CategoriesModel>?;

                        return ListView.separated(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var number = index + 1;
                              var item_id = model![index].id;

                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: width * 0.35,
                                  child: Container(
                                      child: Column(
                                    children: [
                                      SizedBox(
                                        height: 210,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                              baseApiService.apiUrl +
                                                  model![index]
                                                      .image
                                                      .toString(),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                            model![index].name.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color)),
                                      ),
                                    ],
                                  )),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: model?.length ?? 0);
                      case Status.ERROR:
                        return Text(episodes_data_provider.state.message);
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ShowImage(String image) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.fill,
        ));
  }
}
