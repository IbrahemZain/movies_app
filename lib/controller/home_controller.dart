import 'dart:async';

import 'package:get/get.dart';
import 'package:movies/models/movie_detail_model.dart';
import 'package:movies/models/movie_model.dart';
import 'package:dio/dio.dart';

final dio = Dio();
const String baseUrl = "https://api.themoviedb.org/3";
const String apiKey = "api_key=f1a8883f6b121a37342cf804fcc6f3d6";

class HomeController extends GetxController {
  List<MovieModel> nowPlayingMoviesList = [];
  List<MovieDetailModel> favoriteMovies = [];

  bool movieIsFavorite = false;

  addToFavorite(MovieDetailModel movie){
    favoriteMovies.add(movie);
  }

  bool isFavorite(MovieDetailModel movie) {
    favoriteMovies.forEach((element) {
      if(element.id == movie.id){
        movieIsFavorite = true;
      }else{
        movieIsFavorite = false;
      }
    });
    return movieIsFavorite;
  }

  static String movieDetailPath(int movieId) =>
      "$baseUrl/movie/$movieId?$apiKey";


  Future<List<MovieModel>> getNowPlayingMovies() async {
    const String nowPlayingMoviesPath = "$baseUrl/movie/now_playing?$apiKey";
    final response = await dio.get(nowPlayingMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw "Error";
    }
  }

  Future<MovieDetailModel> getMovieDetails(movieId) async {
    final response = await Dio().get(movieDetailPath(movieId));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(response.data);
    } else {
      throw "Error";
    }
  }

}