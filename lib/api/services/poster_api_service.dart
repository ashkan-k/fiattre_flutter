import 'package:dio/dio.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';

class PosterApiService extends BaseApiService{
  dynamic GetPostersData([location]) async {
    final response = await Dio().get("${apiUrl}/api/posters/?location=${location ?? ''}",);
    return response;
  }
}