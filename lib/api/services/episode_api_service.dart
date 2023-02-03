import 'package:dio/dio.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';

class EpisodeApiService extends BaseApiService{
  dynamic GetSpecialEpisodesData([location]) async {
    final response = await Dio().get("${apiUrl}/api/episodes/specials/");
    return response;
  }
}