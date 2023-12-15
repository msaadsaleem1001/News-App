
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:news_app/Data/app_exceptions.dart';
import 'base_api_services.dart';

class ApiServices extends BaseApiServices{

  @override
  Future<dynamic> getApi(String url) async{
    dynamic returnResponse;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      returnResponse = responseReturning(response);
    }
    on SocketException{
      throw InternetException();
    }on RequestTimeOut{
      throw RequestTimeOut('Request Timeout');
    }
    return returnResponse;
  }


  dynamic responseReturning(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException();
      default:
        throw FetchDataException('Error while fetching data + ${response.statusCode.toString()}');
    }
  }

}