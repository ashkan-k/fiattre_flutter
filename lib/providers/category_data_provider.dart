import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:fiatre_app/api/models/categories_model.dart';
import 'package:fiatre_app/api/services/category_api_service.dart';
import 'package:flutter/material.dart';

class CategoryDataProvider extends ChangeNotifier{
  CategoryApiService episodeApiService = CategoryApiService();
  late ResponseModel state;
  var response;
  late List<CategoriesModel> data;
  int location = 0;

  GetAllCategoriesWithEpisodes(location) async {
    state = ResponseModel.loading('loading...');
    try{
      response = await episodeApiService.GetAllCategoriesWithEpisodesData(location);
      if (response.statusCode == 200){
        Iterable l = response.data;
        data = List<CategoriesModel>.from(l.map((model)=> CategoriesModel.fromJson(model)));
        state = ResponseModel.completed(data);
        this.location = location;
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