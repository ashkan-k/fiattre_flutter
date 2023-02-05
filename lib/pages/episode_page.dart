import 'package:flutter/material.dart';

import 'components/my_app_bar.dart';

class EpisodePage extends StatefulWidget {
  int? episodeId;
  EpisodePage(this.episodeId, {Key? key}) : super(key: key);

  @override
  State<EpisodePage> createState() => _EpisodePageState(this.episodeId);
}

class _EpisodePageState extends State<EpisodePage> {
  int? episodeId;

  _EpisodePageState(this.episodeId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('bbbbbbbbbbbbbbbbbbbb');
    print(this.episodeId);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.65,
              width: double.infinity,
              child: Center(child: Text('vvvvvvvvvvvv')),
            ),
          ],
        ),
      ),
    );
  }
}
