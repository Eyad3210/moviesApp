import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_app/models/movie_details.dart';
import 'package:movie_app/services/crud.dart';

import '../main.dart';

class DetailsController extends GetxController {
  var isLoading = false.obs;

  Crud crud = Crud();
  MovieDetails? movieDetails;
  final MyStorage storage = MyStorage();



  getMovieDetails(String url, int movieId) async {
    try {
      isLoading.value = true;
      var response = await crud.getRequest("$url$movieId");
      if (response != null) {
        movieDetails = MovieDetails.fromJson(jsonDecode(response));
        
      }
    } finally {
      isLoading.value = false;
    }
  }
  
}
