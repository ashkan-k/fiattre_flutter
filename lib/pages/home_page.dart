import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:fiatre_app/api/models/categories_model.dart';
import 'package:fiatre_app/api/services/episode_api_service.dart';
import 'package:fiatre_app/pages/components/my_app_bar.dart';
import 'package:fiatre_app/providers/episode_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    final episodeDataProvider = Provider.of<EpisodeDataProvider>(context, listen: false);
    episodeDataProvider.GetAllCategoriesWithEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final episodeDataProvider = Provider.of<EpisodeDataProvider>(context);

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
              padding: const EdgeInsets.all(30),
              child: SizedBox(
                height: 250,
                child: Consumer<EpisodeDataProvider>(
                  builder: (context, episodes_data_provider, child) {
                    print('bbbbbbbbbbbbbbbbbb');
                    print(episodes_data_provider.state.status);

                    switch (episodes_data_provider.state.status) {
                      case Status.LOADING:
                        return SizedBox(
                          height: 80,
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.0, bottom: 8, left: 8),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: SizedBox(
                                                    width: 25,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            width: 70,
                                            height: 40,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    baseColor: Colors.grey.shade400,
                                    highlightColor: Colors.white);
                              }),
                        );
                      case Status.COMPLETED:
                        List<CategoriesModel>? model = episodes_data_provider.data as List<CategoriesModel>?;

                        return ListView.separated(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var number = index + 1;
                              var item_id = model![index].id;

                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  width: width * 0.35,
                                  height: double.infinity,
                                  child: Column(
                                    children: [

                                      SizedBox(
                                        height: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.network(model![index].image.toString(), fit: BoxFit.fill),
                                        ),
                                      ),

                                      Text('فیلم یک')

                                    ],
                                  ),
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
