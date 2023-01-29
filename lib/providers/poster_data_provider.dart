import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:flutter/material.dart';
import '../api/models/posters_model.dart';
import '../api/services/poster_api_service.dart';

class PosterDataProvider extends ChangeNotifier{
  PosterApiService posterApiService = PosterApiService();
  late ResponseModel state;
  var response;
  late List<PostersModel> data;
  int location = 0;

  GetPosters([location]) async {
    state = ResponseModel.loading('loading...');
    try{
      response = await posterApiService.GetPostersData(location);
      if (response.statusCode == 200){
        Iterable l = response.data;
        data = List<PostersModel>.from(l.map((model)=> PostersModel.fromJson(model)));
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