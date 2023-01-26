import 'package:dio/dio.dart';
import 'package:fiatre_app/api/services/base_service_provider.dart';

class EpisodeApiService extends BaseApiService{
  dynamic GetAllCategoriesWithEpisodesData() async {
    final response = await Dio().get("${apiUrl}/api/categories/with-episodes/",);
    return response;
  }

  dynamic GetAllCryptoData() async {
    final response = await Dio().get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=1000&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap",);
    return response;
  }

  dynamic GetTopGainerData() async {
    var response;
    response = await Dio().get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap");
    return response;
  }

  dynamic GetTopLosersData() async {
    var response;
    response = await Dio().get("https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=asc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap");
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