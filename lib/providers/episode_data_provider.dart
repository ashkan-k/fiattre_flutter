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
  late EpisodesModel single_data;
  int location = 0;

  Future<EpisodesModel> GetEpisode(String episode_slug) async {
    state = ResponseModel.loading('loading...');
    try{
      response = await episodeApiService.GetEpisodeData(episode_slug);
      if (response.statusCode == 200){
        single_data = EpisodesModel.fromJson(response.data);
        state = ResponseModel.completed(single_data);
        this.location = location;
      }else{
        state = ResponseModel.loading('something is wrong...');
      }

      notifyListeners();
      return single_data;
    }catch(e){
      state = ResponseModel.loading('please check your connection...');
      notifyListeners();
      return single_data;
    }
  }

  Future<List<EpisodesModel>> GetSpecialEpisodes() async {
    state = ResponseModel.loading('loading...');
    try{
      response = await episodeApiService.GetSpecialEpisodesData();
      if (response.statusCode == 200){
        Iterable l = response.data;
        data = List<EpisodesModel>.from(l.map((model)=> EpisodesModel.fromJson(model)));
        state = ResponseModel.completed(data);
        this.location = location;
      }else{
        state = ResponseModel.loading('something is wrong...');
      }

      notifyListeners();
      return data;
    }catch(e){
      state = ResponseModel.loading('please check your connection...');
      notifyListeners();
      return data;
    }
  }
}