import 'dart:async';
import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:fiatre_app/api/models/categories_model.dart';
import 'package:fiatre_app/api/models/posters_model.dart';
import 'package:fiatre_app/api/models/posters_model.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';
import 'package:fiatre_app/pages/components/my_app_bar.dart';
import 'package:fiatre_app/providers/category_data_provider.dart';
import 'package:fiatre_app/providers/helpers_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../api/models/sliders_model.dart';
import '../providers/poster_data_provider.dart';
import '../providers/slider_data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  late Future<List<CategoriesModel>> categories_1;
  late Future<List<CategoriesModel>> categories_2;
  late Future<List<CategoriesModel>> categories_3;
  late Future<List<CategoriesModel>> categories_4;
  late Future<List<CategoriesModel>> categories_5;
  late Future<List<CategoriesModel>> categories_6;

  late Future<List<PostersModel>> posters_1;
  late Future<List<PostersModel>> posters_2;
  late Future<List<PostersModel>> posters_3;
  late Future<List<PostersModel>> posters_4;
  late Future<List<PostersModel>> posters_5;
  late Future<List<PostersModel>> posters_6;

  @override
  void initState() {
    super.initState();

    final categoryDataProviderLocation = Provider.of<CategoryDataProvider>(context, listen: false);
    categories_1 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(1);
    categories_2 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(2);
    categories_3 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(3);
    categories_4 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(4);
    categories_5 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(5);
    categories_6 = categoryDataProviderLocation.GetAllCategoriesWithEpisodes(6);

    final posterDataProvider = Provider.of<PosterDataProvider>(context, listen: false);
    posters_1 = posterDataProvider.GetPosters(1);
    posters_2 = posterDataProvider.GetPosters(2);
    posters_3 = posterDataProvider.GetPosters(3);
    posters_4 = posterDataProvider.GetPosters(4);
    posters_5 = posterDataProvider.GetPosters(5);
    posters_6 = posterDataProvider.GetPosters(6);

    final sliderDataProvider = Provider.of<SliderDataProvider>(context, listen: false);
    sliderDataProvider.GetSliders();
  }

  @override
  void dispose() {
    pageController.dispose();
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
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              height: height * 0.65,
              width: double.infinity,
              child:  Consumer<SliderDataProvider>(
                builder: (context, sliderDataProvider, child) {

                  switch (sliderDataProvider.state.status) {
                    case Status.LOADING:
                      return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.black,
                          fontSize: 80,
                          dotSpacing: 3,
                        ),
                      );
                    case Status.COMPLETED:
                      List<SlidersModel>? model = sliderDataProvider.data as List<SlidersModel>?;

                      AutoPlaySlider(model);

                      return Stack(
                        children: [
                          PageView(
                            controller: pageController,
                            children: List.generate(model!.length, (index){
                              return InkWell(
                                onTap: () async {
                                  await HelpersProvider.LunchUrl(model[index].link.toString(), false);
                                },
                                child: HelpersProvider.ShowImage(model[index].file_mobile.toString(), 'network', 0),
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
                                onDotClicked: (index) => pageController.animateToPage(
                                    index,
                                    duration: Duration(milliseconds: 10),
                                    curve: Curves.bounceOut),
                              ),
                            ),
                          )
                        ],
                      );
                    case Status.ERROR:
                      return Text(posterDataProvider.state.message);
                    default:
                      return Container();
                  }
                },
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
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(best_items_images![0][0].toString(), false);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Image.asset(best_items_images![0][1].toString(), fit: BoxFit.fill, width: width / 2 - 20),
                                  ),
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
                        ),
                        InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(best_items_images![1][0].toString(), false);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Image.asset(best_items_images![1][1].toString(), fit: BoxFit.fill, width: width / 2 - 20),
                                  ),
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
                          await HelpersProvider.LunchUrl(best_items_images![2][0].toString(), false);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(best_items_images![2][1].toString(), fit: BoxFit.fill, width: width / 2 - 20),
                                ),
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
                      ),
                      InkWell(
                        onTap: () async {
                          await HelpersProvider.LunchUrl(best_items_images![3][0].toString(), false);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(best_items_images![3][1].toString(), fit: BoxFit.fill, width: width / 2 - 20),
                                ),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context)
                    .iconTheme
                    .color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_1,
                builder: (context, snapshot) {

                    if (snapshot.hasData) {
                      List<PostersModel>? model = snapshot.data;

                      return Column(
                        children: List.generate(model!.length, (index){
                          return InkWell(
                            onTap: () async {
                              await HelpersProvider.LunchUrl(model[index].link.toString(), false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              child: Image.network(model![index].image.toString(), fit: BoxFit.fill, width: width * 0.90),
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
                    }else{
                      return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.black,
                          fontSize: 80,
                          dotSpacing: 3,
                        ),
                      );
                    }

                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_1,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<CategoriesModel>? model = snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('go to all this category episodes');
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
                                        Text(model![index].name.toString(),
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
                                  child: ListView.separated(
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index2) {
                                        var episode = model![index].episodes![index2];

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
                                                        child: Image.network(baseApiService.apiUrl + episode.image.toString(), fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 3),
                                                      child: Text(
                                                          episode.title.toString(),
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
                                      itemCount: model![index].episodes?.length ?? 0),
                                ),
                              )
                            ],
                          ),
                        );
                      },),
                    );
                  }
                  else{
                    return Center(
                        child: JumpingDotsProgressIndicator(
                        color: Colors.black,
                        fontSize: 80,
                        dotSpacing: 3,
                    ));
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context)
                    .iconTheme
                    .color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_2,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index){
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Image.network(model![index].image.toString(), fit: BoxFit.fill, width: width * 0.90),
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
                  }else{
                    return Center(
                      child: JumpingDotsProgressIndicator(
                        color: Colors.black,
                        fontSize: 80,
                        dotSpacing: 3,
                      ),
                    );
                  }

                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_2,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<CategoriesModel>? model = snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('go to all this category episodes');
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
                                        Text(model![index].name.toString(),
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
                                  child: ListView.separated(
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index2) {
                                        var episode = model![index].episodes![index2];

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
                                                        child: Image.network(baseApiService.apiUrl + episode.image.toString(), fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 3),
                                                      child: Text(
                                                          episode.title.toString(),
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
                                      itemCount: model![index].episodes?.length ?? 0),
                                ),
                              )
                            ],
                          ),
                        );
                      },),
                    );
                  }
                  else{
                    return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.black,
                          fontSize: 80,
                          dotSpacing: 3,
                        ));
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context)
                    .iconTheme
                    .color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_3,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<CategoriesModel>? model = snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('go to all this category episodes');
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
                                        Text(model![index].name.toString(),
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
                                  child: ListView.separated(
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index2) {
                                        var episode = model![index].episodes![index2];

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
                                                        child: Image.network(baseApiService.apiUrl + episode.image.toString(), fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 3),
                                                      child: Text(
                                                          episode.title.toString(),
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
                                      itemCount: model![index].episodes?.length ?? 0),
                                ),
                              )
                            ],
                          ),
                        );
                      },),
                    );
                  }
                  else{
                    return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.black,
                          fontSize: 80,
                          dotSpacing: 3,
                        ));
                  }
                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_3,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index){
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Image.network(model![index].image.toString(), fit: BoxFit.fill, width: width * 0.90),
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
                  }else{
                    return Center(
                      child: JumpingDotsProgressIndicator(
                        color: Colors.black,
                        fontSize: 80,
                        dotSpacing: 3,
                      ),
                    );
                  }

                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context)
                    .iconTheme
                    .color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_4,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index){
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Image.network(model![index].image.toString(), fit: BoxFit.fill, width: width * 0.90),
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
                  }else{
                    return Center(
                      child: JumpingDotsProgressIndicator(
                        color: Colors.black,
                        fontSize: 80,
                        dotSpacing: 3,
                      ),
                    );
                  }

                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_4,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<CategoriesModel>? model = snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('go to all this category episodes');
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
                                        Text(model![index].name.toString(),
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
                                  child: ListView.separated(
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index2) {
                                        var episode = model![index].episodes![index2];

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
                                                        child: Image.network(baseApiService.apiUrl + episode.image.toString(), fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 3),
                                                      child: Text(
                                                          episode.title.toString(),
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
                                      itemCount: model![index].episodes?.length ?? 0),
                                ),
                              )
                            ],
                          ),
                        );
                      },),
                    );
                  }
                  else{
                    return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.black,
                          fontSize: 80,
                          dotSpacing: 3,
                        ));
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context)
                    .iconTheme
                    .color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_5,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index){
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Image.network(model![index].image.toString(), fit: BoxFit.fill, width: width * 0.90),
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
                  }else{
                    return Center(
                      child: JumpingDotsProgressIndicator(
                        color: Colors.black,
                        fontSize: 80,
                        dotSpacing: 3,
                      ),
                    );
                  }

                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_5,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<CategoriesModel>? model = snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('go to all this category episodes');
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
                                        Text(model![index].name.toString(),
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
                                  child: ListView.separated(
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index2) {
                                        var episode = model![index].episodes![index2];

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
                                                        child: Image.network(baseApiService.apiUrl + episode.image.toString(), fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 3),
                                                      child: Text(
                                                          episode.title.toString(),
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
                                      itemCount: model![index].episodes?.length ?? 0),
                                ),
                              )
                            ],
                          ),
                        );
                      },),
                    );
                  }
                  else{
                    return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.black,
                          fontSize: 80,
                          dotSpacing: 3,
                        ));
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
              child: Container(
                height: 1,
                color: Theme.of(context)
                    .iconTheme
                    .color,
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: posters_6,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<PostersModel>? model = snapshot.data;

                    return Column(
                      children: List.generate(model!.length, (index){
                        return InkWell(
                          onTap: () async {
                            await HelpersProvider.LunchUrl(model[index].link.toString(), false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Image.network(model![index].image.toString(), fit: BoxFit.fill, width: width * 0.90),
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
                  }else{
                    return Center(
                      child: JumpingDotsProgressIndicator(
                        color: Colors.black,
                        fontSize: 80,
                        dotSpacing: 3,
                      ),
                    );
                  }

                },
              ),
            ),

            SizedBox(
              child: FutureBuilder(
                future: categories_6,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<CategoriesModel>? model = snapshot.data as List<CategoriesModel>?;

                    return Column(
                      children: List.generate(model!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('go to all this category episodes');
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
                                        Text(model![index].name.toString(),
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
                                  child: ListView.separated(
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index2) {
                                        var episode = model![index].episodes![index2];

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
                                                        child: Image.network(baseApiService.apiUrl + episode.image.toString(), fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 3),
                                                      child: Text(
                                                          episode.title.toString(),
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
                                      itemCount: model![index].episodes?.length ?? 0),
                                ),
                              )
                            ],
                          ),
                        );
                      },),
                    );
                  }
                  else{
                    return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.black,
                          fontSize: 80,
                          dotSpacing: 3,
                        ));
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  void AutoPlaySlider(data)
  {
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
