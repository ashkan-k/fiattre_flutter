import 'package:fiatre_app/api/models/categories_model.dart';
import 'package:fiatre_app/api/models/categories_with_episodes_model.dart';
import 'package:fiatre_app/api/ResponseModel.dart';
import 'package:fiatre_app/api/services/episode_api_service.dart';
import 'package:flutter/material.dart';

import '../api/models/posters_model.dart';
import '../api/models/sliders_model.dart';
import '../api/services/poster_api_service.dart';
import '../api/services/slider_api_service.dart';

class SliderDataProvider extends ChangeNotifier{
  SliderApiService sliderApiService = SliderApiService();
  late ResponseModel state;
  var response;
  late List<SlidersModel> data;

  GetSliders() async {
    state = ResponseModel.loading('loading...');
    try{
      response = await sliderApiService.GetSlidersData();
      if (response.statusCode == 200){
        Iterable l = response.data;
        data = List<SlidersModel>.from(l.map((model)=> SlidersModel.fromJson(model)));
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