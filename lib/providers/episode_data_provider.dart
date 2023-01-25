import 'package:fiatre_app/api/models/categories_model.dart';
import 'package:fiatre_app/api/models/categories_with_episodes_model.dart';
import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:fiatre_app/api/services/episode_api_service.dart';
import 'package:flutter/material.dart';

class EpisodeDataProvider extends ChangeNotifier{
  EpisodeApiService episodeApiService = EpisodeApiService();
  late ResponseModel state;
  var response;
  late List<CategoriesModel> data;

  GetAllCategoriesWithEpisodes() async {
    state = ResponseModel.loading('loading...');
    try{
      response = await episodeApiService.GetAllCategoriesWithEpisodesData();
      if (response.statusCode == 200){
        Iterable l = response.data;
        data = List<CategoriesModel>.from(l.map((model)=> CategoriesModel.fromJson(model)));
        state = ResponseModel.completed(data);
      }else{
        state = ResponseModel.loading('something is wrong...');
      }

      notifyListeners();
    }catch(e){
      print(e.toString());
      state = ResponseModel.loading('please check your connection...');
      notifyListeners();
    }
  }
}