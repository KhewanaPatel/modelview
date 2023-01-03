import 'package:flutter/cupertino.dart';
import 'package:modelview/data/response/api_response.dart';
import 'package:modelview/model/movies_model.dart';
import 'package:modelview/respository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();
  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMovieList(ApiResponse<MovieListModel>response){
    moviesList=response;
    notifyListeners();
  }


  Future<void> fetchMoviesListApi() async {
    setMovieList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value) {
      setMovieList(ApiResponse.completed(value));

    }).onError((error, stackTrace) {
      setMovieList(ApiResponse.error(error.toString()));
    });

  }
}
