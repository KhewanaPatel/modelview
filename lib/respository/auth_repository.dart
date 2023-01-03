import 'package:modelview/data/network/baseApiServices.dart';
import 'package:modelview/data/network/networkApiServices.dart';

import '../res/app_url.dart';

class AuthRepository{
  BaseApiServices _apiServices=NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async{

try{

  dynamic response=await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
  return response;

  }catch(e){
  throw e;
  }

}
Future<dynamic> signupApi(dynamic data) async{
  try{
    dynamic response=await _apiServices.getPostApiResponse(AppUrl.registerApiEndPoint, data);
return response;
  }catch(e){
    throw e;
  }
}
}