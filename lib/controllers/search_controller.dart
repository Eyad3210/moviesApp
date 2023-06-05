import 'dart:convert';

import 'package:get/get.dart';

import '../services/crud.dart';

class SeacrhController extends GetxController{
    var movieSearchList = [].obs;
  var isLoading = false.obs;
  Crud crud = Crud();

  getMovieSearch(String url) async {
    movieSearchList.clear();
    try {
      isLoading.value = true;
      var response = await crud.getRequest(url);
      if (response != null) {
        var list = jsonDecode(response);
        movieSearchList.addAll(list['results']);

        print(movieSearchList);
      }
    } finally {
      isLoading.value = false;
    }
  }
}