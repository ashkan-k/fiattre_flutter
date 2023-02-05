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

    return Scaffold(
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
            case Status.COMPLETED: EpisodesModel? episode = episodeDataProvider.single_data as EpisodesModel?;

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

                          Padding(
                            padding: EdgeInsets.only(right: width * 0.055),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.1),
                                  child: Row(
                                    children: [
                                      Text(
                                          episode.title
                                              .toString().substring(0, 18),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 30,
                                              color: Theme.of(
                                                  context)
                                                  .iconTheme
                                                  .color))
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .remove_red_eye_outlined,
                                        color: Colors.amber,
                                        size: 30,
                                      ),
                                      const SizedBox(width: 5),
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
                                      const SizedBox(width: 5),
                                      Text(
                                        '${episode.view_count ?? '---'} بازدید',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
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
    );
  }
}
