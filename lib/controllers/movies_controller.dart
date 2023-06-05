import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_app/services/crud.dart';

class MoviesController extends GetxController {
  var moviesList = [].obs;
  var isLoading = false.obs;
  Crud crud = Crud();

  getMovies(String url) async {
    try {
      isLoading.value = true;
      var response = await crud.getRequest(url);
      if (response != null) {
        var list = jsonDecode(response);
        moviesList.addAll(list['results']);

      }
    } finally {
      isLoading.value = false;
    }
  }
  
}
