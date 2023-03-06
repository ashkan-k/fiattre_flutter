import 'package:dio/dio.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';

class CategoryApiService extends BaseApiService{
  dynamic GetAllCategoriesWithEpisodesData([location]) async {
    final response = await Dio().get("${apiUrl}/api/categories/with-episodes/?location=${location ?? ''}",);
    print('vvvvvvvvvvvvvvvvvvvv');
    print(response.statusCode);
    print(response.data);
    return response;
  }

  dynamic SubmitSignUp(name, email, password) async {
    final form = FormData.fromMap({
      'name': name,
      'email': email,
      'password': password,
    });

    var response = await Dio().post(
        'https://besenior.ir/api/register',
        data: form
    );

    return response;
  }
}