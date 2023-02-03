import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:fiatre_app/api/models/categories_model.dart';
import 'package:fiatre_app/api/services/category_api_service.dart';
import 'package:flutter/material.dart';

import '../api/models/episodes_model.dart';
import '../api/services/episode_api_service.dart';

class EpisodeDataProvider extends ChangeNotifier{
  EpisodeApiService episodeApiService = EpisodeApiService();
  late ResponseModel state;
  var response;
  late List<EpisodesModel> data;
  int location = 0;

  Future<List<EpisodesModel>> GetSpecialEpisodes() async {
    state = ResponseModel.loading('loading...');
    try{
      response = await episodeApiService.GetSpecialEpisodesData();
      if (response.statusCode == 200){
        Iterable l = response.data;
        data = List<EpisodesModel>.from(l.map((model)=> EpisodesModel.fromJson(model)));
        print('cfccccccccccccccccc');
        print(data);
        state = ResponseModel.completed(data);
        this.location = location;
      }else{
        state = ResponseModel.loading('something is wrong...');
      }

      notifyListeners();
      return data;
    }catch(e){
      print('cfccccccccccccccccc');
      print(e.toString());
      state = ResponseModel.loading('please check your connection...');
      notifyListeners();
      return data;
    }
  }
}