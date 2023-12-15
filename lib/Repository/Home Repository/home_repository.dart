

import 'package:news_app/Data/Api%20Services/api_services.dart';
import 'package:news_app/Res/App%20urls/app_urls.dart';

class HomeRepository{

  final apiServices = ApiServices();

  Future<dynamic> getNews(String url) async{
    final String finalUrl = AppUrls.baseurl+AppUrls.topHeadLines+url+AppUrls.apikey;
    var response = await apiServices.getApi(finalUrl);
    return response;
  }

}