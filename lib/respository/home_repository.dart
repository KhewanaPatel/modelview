import 'package:modelview/model/movies_model.dart';

import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../res/app_url.dart';

class HomeRepository{
  BaseApiServices _apiServices=NetworkApiServices();

  Future<MovieListModel> fetchMoviesList() async{

    try{

      dynamic response=await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response=MovieListModel.fromJson(response);

    }catch(e){
      throw e;
    }

  }

}