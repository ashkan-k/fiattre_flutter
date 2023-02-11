import 'package:fiatre_app/api/models/episodes_model.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import '../api/ResponseModel.dart';
import '../providers/episode_data_provider.dart';
import '../providers/helpers_provider.dart';
import 'components/my_app_bar.dart';

class EpisodePage extends StatefulWidget {
  String? episodeSlug;

  EpisodePage(this.episodeSlug, {Key? key}) : super(key: key);

  @override
  State<EpisodePage> createState() => _EpisodePageState(this.episodeSlug);
}

class _EpisodePageState extends State<EpisodePage> {
  String? episodeSlug;

  _EpisodePageState(this.episodeSlug);

  @override
  void initState() {
    super.initState();
    final episodeDataProvider =
        Provider.of<EpisodeDataProvider>(context, listen: false);
    episodeDataProvider.GetEpisode(episodeSlug!);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: MyAppBar(false),
        body: Consumer<EpisodeDataProvider>(
          builder: (context, episodeDataProvider, child) {
            switch (episodeDataProvider.state.status) {
              case Status.LOADING:
                return Center(
                  child: JumpingDotsProgressIndicator(
                    color: (Theme.of(context).iconTheme.color)!,
                    fontSize: 80,
                    dotSpacing: 3,
                  ),
                );
              case Status.COMPLETED:
                EpisodesModel? episode =
                    episodeDataProvider.single_data as EpisodesModel?;

                return SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: height * 0.75,
                              width: double.infinity,
                              child: HelpersProvider.ShowImageClipRRect(
                                  episode!.cover.toString(), 'network', 0),
                            ),
                            Column(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.055),
                                    child: Column(children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.070),
                                        child: Row(
                                          children: [
                                            Text(
                                                episode.title
                                                    .toString()
                                                    .substring(0, 18),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 30,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.030),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  color: Colors.amber,
                                                  size: 30,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  ':',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${episode.view_count ?? '---'} بازدید',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 15),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.favorite_outline_outlined,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  ':',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${episode.likes_count ?? '---'} لایک',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.020),
                                        child: Row(
                                          children: [
                                            Text(
                                              'کارگردان :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${episode.director ?? '---'}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.020),
                                        child: Row(
                                          children: [
                                            Text(
                                              'نویسنده :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${episode.writer ?? '---'}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.020),
                                        child: Row(
                                          children: [
                                            Text(
                                              'دسته بندی :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${episode.category.name ?? '---'}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.020),
                                        child: Row(
                                          children: [
                                            Text(
                                              'سال ساخت :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${episode.construction_year ?? '---'}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.020),
                                        child: Row(
                                          children: [
                                            Text(
                                              'محصول کشور :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${episode.country ?? '---'}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.020),
                                        child: Row(
                                          children: [
                                            Text(
                                              'ژانر :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${episode.genre ?? '---'}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),


                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.075, right: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: height * 0.080,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                backgroundColor: Theme.of(context)
                                                    .iconTheme
                                                    .color),
                                            child: Row(
                                              children: [
                                                Text('پخش آنلاین',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 22,
                                                      color: Theme.of(context)
                                                          .primaryIconTheme.color,
                                                    )),
                                                SizedBox(width: 20),
                                                Icon(
                                                  Icons.play_circle,
                                                  color: Theme.of(context)
                                                      .buttonColor,
                                                  size: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),


                        Padding(
                          padding: EdgeInsets.only(top: height * 0.050, bottom: height * 0.050, right: height * 0.035, left: height * 0.035),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 0.5,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context).buttonColor, spreadRadius: 3)
                                          ])
                                    ),

                                    SizedBox(width: 20,),

                                    Text('درباره فیلم',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 22,
                                            color:
                                            Theme.of(context).iconTheme.color))
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: height * 0.050),
                                child: Text(HelpersProvider.ParseHtmlString(episode.description.toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color:
                                        Theme.of(context).iconTheme.color)),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: height * 0.050, bottom: height * 0.050, right: height * 0.035, left: height * 0.035),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                TabBar(
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'گالری عکس',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                      height: height * 0.1,
                                    ),
                                    Tab(
                                      child: Text(
                                        'جزییات',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                      height: height * 0.1,
                                    ),
                                    Tab(
                                      child: Text(
                                        'مشابه',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                      height: height * 0.1,
                                    ),
                                    Tab(
                                      child: Text(
                                        'نظرات',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                      height: height * 0.1,
                                    ),
                                  ],
                                  labelColor: Theme.of(context).buttonColor,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.050),
                                  child: SizedBox(
                                    width: width,
                                    height: 500,
                                    child: TabBarView(
                                      children: [
                                        Container(
                                          color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              'Bike',
                                            ),
                                          ),
                                        ),

                                        Container(
                                          color: Colors.pink,
                                          child: Center(
                                            child: Text(
                                              'Car',
                                            ),
                                          ),
                                        ),

                                        Container(
                                          color: Colors.pink,
                                          child: Center(
                                            child: Text(
                                              'Car',
                                            ),
                                          ),
                                        ),

                                        Container(
                                          color: Colors.pink,
                                          child: Center(
                                            child: Text(
                                              'Car',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              case Status.ERROR:
                return Text(episodeDataProvider.state.message);
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
