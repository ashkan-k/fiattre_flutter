import 'package:dio/dio.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';

class EpisodeApiService extends BaseApiService{
  dynamic GetEpisodeData(String episode_slug) async {
    final response = await Dio().get("${apiUrl}/api/episodes/${episode_slug}/");
    return response;
  }

  dynamic GetSpecialEpisodesData([location]) async {
    final response = await Dio().get("${apiUrl}/api/episodes/specials/");
    return response;
  }
}