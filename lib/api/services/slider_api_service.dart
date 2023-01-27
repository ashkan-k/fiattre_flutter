import 'package:dio/dio.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';

class SliderApiService extends BaseApiService{
  dynamic GetSlidersData() async {
    final response = await Dio().get("${apiUrl}/api/sliders/",);
    return response;
  }
}