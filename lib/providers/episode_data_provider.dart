import 'package:fiatre_app/api/models/categories_with_episodes_model.dart';
import 'package:fiatre_app/api/services/ApiService.dart';
import 'package:fiatre_app/api/services/ResponseModel.dart';
import 'package:flutter/material.dart';

class EpisodeDataProvider extends ChangeNotifier{
  ApiService apiService = ApiService();
  late ResponseModel state;
  var response;

  GetAllCategoriesWithEpisodes() async {
    state = ResponseModel.loading('loading...');

    try{
      response = await apiService.GetAllCategoriesWithEpisodesData();
      if (response.statusCode == 200){
        data = CategoriesWithEpisodesModel.fromJson(response.data);
        state = ResponseModel.completed(data);
      }else{
        state = ResponseModel.loading('something is wrong...');
      }

      notifyListeners();
    }catch(e){
      state = ResponseModel.loading('please check your connection...');
      notifyListeners();
    }
  }
}