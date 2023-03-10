import 'dart:async';
import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:fiatre_app/api/models/categories_model.dart';
import 'package:fiatre_app/api/models/episodes_model.dart';
import 'package:fiatre_app/api/models/posters_model.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';
import 'package:fiatre_app/pages/components/loading.dart';
import 'package:fiatre_app/pages/components/my_app_bar.dart';
import 'package:fiatre_app/providers/category_data_provider.dart';
import 'package:fiatre_app/providers/episode_data_provider.dart';
import 'package:fiatre_app/providers/helpers_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../api/models/sliders_model.dart';
import '../config/my_flutter_app_icons.dart';
import '../providers/poster_data_provider.dart';
import '../providers/slider_data_provider.dart';
import 'episode_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  PageController specialCategoriesPageController = PageController(initialPage: 0);

  late Future<List<CategoriesModel>> categories_1;
  late Future<List<CategoriesModel>> categories_2;
  late Future<List<CategoriesModel>> categories_3;
  late Future<List<CategoriesModel>> categories_4;
  late Future<List<CategoriesModel>> categories_5;
  late Future<List<CategoriesModel>> categories_6;
  late Future<List<CategoriesModel>> categories_7;
  late Future<List<CategoriesModel>> categories_8;
  late Future<List<CategoriesModel>> categories_9;
  late Future<List<CategoriesModel>> categories_10;
  late Future<List<CategoriesModel>> categories_11;
  late Future<List<CategoriesModel>> categories_12;

  late Future<List<PostersModel>> posters_1;
  late Future<List<PostersModel>> posters_2;
  late Future<List<PostersModel>> posters_3;
  late Future<List<PostersModel>> posters_4;
  late Future<List<PostersModel>> posters_5;
  late Future<List<PostersModel>> posters_6;

  late Future<List<EpisodesModel>> special_episodes;

  @override
  void initState() {
    super.initState();

    final categoryDataProviderLocation =
        Provider.of<CategoryDataProvider>(context, listen: false);
    categories_1 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(1);
    categories_2 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(2);
    categories_3 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(3);
    categories_4 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(4);
    categories_5 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(5);
    categories_6 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(6);
    categories_7 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(7);
    categories_8 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(8);
    categories_9 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(9);
    categories_10 =
        categoryDataProviderLocation.GetAllCategoriesWithEpisodes(10);
    categories_11 =
        categoryDataProviderLocation.GetAllCategoriesWithEpisodes(11);
    categories_12 =
        categoryDataProviderLocation.GetAllCategoriesWithEpisodes(9);

    final posterDataProvider =
        Provider.of<PosterDataProvider>(context, listen: false);
    posters_1 = posterDataProvider.GetPosters(1);
    posters_2 = posterDataProvider.GetPosters(2);
    posters_3 = posterDataProvider.GetPosters(3);
    posters_4 = posterDataProvider.GetPosters(4);
    posters_5 = posterDataProvider.GetPosters(5);
    posters_6 = posterDataProvider.GetPosters(6);

    final sliderDataProvider =
        Provider.of<SliderDataProvider>(context, listen: false);
    sliderDataProvider.GetSliders();

    final episodeDataProviderLocation = Provider.of<EpisodeDataProvider>(context, listen: false);
    special_episodes = episodeDataProviderLocation.GetSpecialEpisodes();
  }

  @override
  void dispose() {
    pageController.dispose();
    specialCategoriesPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final posterDataProvider = Provider.of<PosterDataProvider>(context);
    final baseApiService = BaseApiService();

    var best_items_images = [
      [
        'https://fiatre.ir/categories/%D9%81%DB%8C%D9%84%D9%85-%D8%AA%D8%A6%D8%A7%D8%AA%D8%B1/',
        'images/best_items_images/1.jpg',
      ],
      [
        'https://fiatre.ir/categories/%D9%85%D8%B3%D8%AA%D9%86%D8%AF-%D8%AA%D8%A6%D8%A7%D8%AA%D8%B1/',
        'images/best_items_images/2.jpg',
      ],
      [
        'https://www.fiatre.ir/categories/%DA%A9%D8%A7%D8%B1-%D8%AF%D8%B1-%D8%AA%D8%A6%D8%A7%D8%AA%D8%B1/',
        'images/best_items_images/3.jpg',
      ],
      [
        'https://fiatre.ir/categories/%D8%A7%DA%A9%D8%AA%D9%88%D8%B1%D8%B2-%D8%A7%D8%B3%D8%AA%D9%88%D8%AF%DB%8C%D9%88/',
        'images/best_items_images/4.jpg',
      ],
    ];

    return Scaffold(
      appBar: MyAppBar(true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.65,
              width: double.infinity,
              child: Consumer<SliderDataProvider>(
                builder: (context, sliderDataProvider, child) {
                  switch (sliderDataProvider.state.status) {
                    case Status.LOADING:
                      return const MyLoading();
                    case Status.COMPLETED:
                      List<SlidersModel>? model =
                          sliderDataProvider.data as List<SlidersModel>?;

                      // AutoPlaySlider(model);

                      if(model!.isNotEmpty){
                        return Stack(
                          children: [
                            PageView(
                              controller: pageController,
                              children: List.generate(model!.length, (index) {
                                return InkWell(
                                  onTap: () async {
                                    await HelpersProvider.LunchUrl(
                                        model[index].link.toString(), false);
                                  },
                                  child: HelpersProvider.ShowImageClipRRect(
                                      model[index].file_mobile.toString(),
                                      'network',
                                      0),
                                );
                              }),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SmoothPageIndicator(
                                  controller: pageController,
                                  count: model!.length,
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
                                  onDotClicked: (index) =>
                                      pageController.animateToPage(index,
                                          duration: Duration(milliseconds: 350),
                                          curve: Curves.easeIn),
                                ),
                              ),
                            )
                          ],
                        );
                      }else{
                        return const MyLoading();
                      }

                    case Status.ERROR:
                      return Text(posterDataProvider.state.message);
                    default:
                      return Container();
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Container(
                              width: 0.5,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).buttonColor, spreadRadius: 3)
                                  ])
                          ),

                          SizedBox(width: 20,),

                          Text('???????????? ????',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Theme.of(context).iconTheme.color)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(
                                best_items_images![0][0].toString(), false);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Image.asset(
                                        best_items_images![0][1].toString(),
                                        fit: BoxFit.fill,
                                        width: width / 2 - 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text('???????? ??????????',
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
                        ),
                        InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(
                                best_items_images![1][0].toString(), false);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Image.asset(
                                        best_items_images![1][1].toString(),
                                        fit: BoxFit.fill,
                                        width: width / 2 - 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text('?????????? ??????????',
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
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          await HelpersProvider.LunchUrl(
                              best_items_images![2][0].toString(), false);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                      best_items_images![2][1].toString(),
                                      fit: BoxFit.fill,
                                      width: width / 2 - 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text('?????? ???? ??????????',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color:
                                            Theme.of(context).iconTheme.color)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await HelpersProvider.LunchUrl(
                              best_items_images![3][0].toString(), false);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                      best_items_images![3][1].toString(),
                                      fit: BoxFit.fill,
                                      width: width / 2 - 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text('???????????? ??????????????',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color:
                                            Theme.of(context).iconTheme.color)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context).iconTheme.color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_1,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(
                                model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Image.network(
                                                model![index].image.toString(),
                                                fit: BoxFit.fill,
                                                width: width * 0.90),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_1,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                        snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                              model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                  children: [
                                                    SizedBox(
                                                       height: height * 0.240,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        child: Image.network(
                                                            baseApiService
                                                                    .apiUrl +
                                                                episode.image
                                                                    .toString(),
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                      child: Text(
                                                          episode.title
                                                              .toString().length > 18 ? episode.title
                                                              .toString()
                                                              .substring(0, 18) : episode.title
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color)),
                                                    ),
                                                  ],
                                                )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount: model![index].episodes?.length ?? 0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_2,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context).iconTheme.color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_2,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(
                                model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Image.network(
                                                model![index].image.toString(),
                                                fit: BoxFit.fill,
                                                width: width * 0.90),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_3,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context).iconTheme.color,
              ),
            ),

            SizedBox(
              height: height * 1.5,
              width: double.infinity,
              child: FutureBuilder(
                future: special_episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<EpisodesModel>? model = snapshot.data as List<EpisodesModel>?;

                    return SizedBox(
                      height: height * 1.5,
                      width: double.infinity,
                      child: PageView(
                        controller: specialCategoriesPageController,
                        children: List.generate(model!.length, (index) {
                          EpisodesModel episode = model[index];

                          return  Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 1.4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context).accentColor, spreadRadius: 3)
                                            ]),
                                      ),
                                      Stack(
                                        children: [
                                          Center(
                                            child: Container(
                                              height: height * 0.4,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Theme.of(context).accentColor,
                                                        spreadRadius: 3)
                                                  ],
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color(0xFF262020),
                                                      Color(0xFF69686d),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(25),
                                            child: Center(
                                              child: SizedBox(
                                                height: height * 0.450,
                                                width: width,
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(10)),
                                                  child: Image.network(
                                                      baseApiService.apiUrl + episode.image.toString(),
                                                      fit: BoxFit.fill,
                                                      width: width / 2 - 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: height * 0.510),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 25),
                                                  child: Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Column(
                                                      children: [
                                                        Directionality(
                                                            textDirection: TextDirection.rtl,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '????????:',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: 20,
                                                                      color: Theme.of(context)
                                                                          .iconTheme
                                                                          .color),
                                                                ),
                                                                const SizedBox(width: 15),
                                                                Text(
                                                                  '${episode.time ?? '---'} ??????????',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: 20,
                                                                      color: Theme.of(context)
                                                                          .iconTheme
                                                                          .color),
                                                                ),
                                                              ],
                                                            )),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(top: 10),
                                                          child: Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    '??????????:',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        fontSize: 20,
                                                                        color: Theme.of(context)
                                                                            .iconTheme
                                                                            .color),
                                                                  ),
                                                                  const SizedBox(width: 15),
                                                                  Text(
                                                                    '${episode.construction_year ?? '---'}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        fontSize: 20,
                                                                        color: Theme.of(context)
                                                                            .iconTheme
                                                                            .color),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(top: 10),
                                                          child: Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .remove_red_eye_outlined,
                                                                    color: Theme.of(context)
                                                                        .iconTheme
                                                                        .color,
                                                                    size: 30,
                                                                  ),
                                                                  Text(
                                                                    ':',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        fontSize: 20,
                                                                        color: Theme.of(context)
                                                                            .iconTheme
                                                                            .color),
                                                                  ),
                                                                  const SizedBox(width: 15),
                                                                  Text(
                                                                    '${episode.view_count ?? '---'} ????????????',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        fontSize: 20,
                                                                        color: Theme.of(context)
                                                                            .iconTheme
                                                                            .color),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .favorite_outline_outlined,
                                                                    color: Theme.of(context)
                                                                        .iconTheme
                                                                        .color,
                                                                    size: 30,
                                                                  ),
                                                                  Text(
                                                                    ':',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        fontSize: 20,
                                                                        color: Theme.of(context)
                                                                            .iconTheme
                                                                            .color),
                                                                  ),
                                                                  const SizedBox(width: 15),
                                                                  Text(
                                                                    '${episode.likes_count ?? '---'} ????????',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold,
                                                                        fontSize: 20,
                                                                        color: Theme.of(context)
                                                                            .iconTheme
                                                                            .color),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.all(25),
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: height * 0.07,
                                                      width: width,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(12)),
                                                            backgroundColor: Theme.of(context).primaryColor),
                                                        child: Text(
                                                          episode.title.toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18,
                                                              color: Theme.of(context).buttonColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.all(25),
                                                  child: SizedBox(
                                                    height: height * 0.06,
                                                    child: ListView.separated(
                                                        reverse: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index2) {
                                                          return Padding(
                                                            padding: const EdgeInsets.only(right: 10),
                                                            child: SizedBox(
                                                              height: height * 0.06,
                                                              width: width / 2 - 20,
                                                              child: ElevatedButton(
                                                                onPressed: () {},
                                                                style: ElevatedButton.styleFrom(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius.circular(12)),
                                                                    backgroundColor: Theme.of(context).unselectedWidgetColor),
                                                                child: Text(
                                                                  episode.awards_list![index2].toString(),
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15,
                                                                      color: Theme.of(context)
                                                                          .iconTheme
                                                                          .color),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder: (context, index) {
                                                          return const Divider();
                                                        },
                                                        itemCount:episode.awards_list?.length ?? 0),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: height * 0.3,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(25),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: Text(
                                                                '?????????? ????????????:',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 25,
                                                                    color: Theme.of(context)
                                                                        .iconTheme
                                                                        .color),
                                                              )),

                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.only(top: 10),
                                                            child: Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: Text(
                                                                HelpersProvider.ParseHtmlString(episode.description.toString().substring(0, 180 >= episode.description!.length ? episode.description!.length : 180)),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 18,
                                                                    color: Theme.of(context)
                                                                        .iconTheme
                                                                        .color),
                                                              ),),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.all(width * 0.050),
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: height * 0.07,
                                                      width: width,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(12)),
                                                            backgroundColor: Theme.of(context).primaryColor),
                                                        child: Icon(CustomIcons.keyboard_arrow_down, color: Theme.of(context).unselectedWidgetColor, size: 40),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                        }),
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: height * 0.06,
                      width: width / 2 - 30,
                      child: ElevatedButton(
                        onPressed: () {
                          try{
                            specialCategoriesPageController.previousPage(duration: Duration(milliseconds: 350), curve: Curves.easeIn);
                          }catch(exception){}
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(12)),
                            backgroundColor: Theme.of(context).primaryIconTheme.color),
                        child: Icon(Icons.arrow_back_ios, size: 18,
                            color: Theme.of(context)
                                .iconTheme
                                .color),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.06,
                      width: width / 2 - 30,
                      child: ElevatedButton(
                        onPressed: () {
                          try{
                            specialCategoriesPageController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.easeIn);
                          }catch(exception){}
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(12)),
                            backgroundColor: Theme.of(context).primaryIconTheme.color),
                        child: Icon(Icons.arrow_forward_ios, size: 18,
                            color: Theme.of(context)
                                .iconTheme
                                .color),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context).iconTheme.color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_4,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            Padding(padding: const EdgeInsets.only(bottom: 35)),

            SizedBox(
              child: FutureBuilder(
                future: posters_3,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(
                                model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Image.network(
                                                model![index].image.toString(),
                                                fit: BoxFit.fill,
                                                width: width * 0.90),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context).iconTheme.color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_5,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_4,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(
                                model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Image.network(
                                                model![index].image.toString(),
                                                fit: BoxFit.fill,
                                                width: width * 0.90),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context).iconTheme.color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_6,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_5,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(
                                model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Image.network(
                                                model![index].image.toString(),
                                                fit: BoxFit.fill,
                                                width: width * 0.90),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context).iconTheme.color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_7,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_8,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_9,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_10,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_11,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_12,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel>? model =
                    snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(
                        model!.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(
                                              'go to all this category episodes');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            Icon(Icons.circle,
                                                size: 10,
                                                color: Theme.of(context)
                                                    .buttonColor),
                                            SizedBox(width: 15),
                                            Text('???????????? ??????',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Theme.of(context)
                                                        .buttonColor)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(model![index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 0),
                                  child: SizedBox(
                                    height: height * 0.305,
                                    child: ListView.separated(
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index2) {
                                          var episode =
                                          model![index].episodes![index2];

                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EpisodePage(episode.slug)));
                                              },
                                              child: SizedBox(
                                                width: width * 0.35,
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                           height: height * 0.240,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                            child: Image.network(
                                                                baseApiService
                                                                    .apiUrl +
                                                                    episode.image
                                                                        .toString(),
                                                                fit: BoxFit.fill),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                          child: Text(
                                                              episode.title
                                                                  .toString().length > 18 ? episode.title
                                                                  .toString()
                                                                  .substring(0, 18) : episode.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                      context)
                                                                      .iconTheme
                                                                      .color)),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount:
                                        model![index].episodes?.length ??
                                            0),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const MyLoading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void AutoPlaySlider(data) {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentIndex <= data.length) {
        pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
        currentIndex++;
      } else {
        currentIndex = 0;
        pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }
}
