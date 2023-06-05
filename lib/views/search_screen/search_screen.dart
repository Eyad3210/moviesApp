import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:movie_app/controllers/search_controller.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/services/crud.dart';
import 'package:movie_app/views/details_screen/details_screen.dart';

import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var controller = Get.put(SeacrhController());
  String query = "";
  final _baseUrl =
      'https://api.themoviedb.org/3/search/movie?include_adult=false';
  Crud crud = Crud();
  int _page = 1;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1;

      var res = await controller.crud
          .getRequest("$_baseUrl&query=$query&page=$_page");
      var list = jsonDecode(res);

      if (list != null) {
        setState(() {
          controller.movieSearchList.addAll(list['results']);
        });
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    controller.getMovieSearch("$_baseUrl&query=$query&page=$_page");

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
  }

  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Obx(() => controller.isLoading.value == false
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: textController,
                                onChanged: (value) {
                                  query = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: "  Search with title of movie",
                                  border: InputBorder.none,
                                ),
                                maxLines: null,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: IconButton(
                              onPressed: () {
                                _firstLoad();
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.movieSearchList.length,
                          controller: _controller,
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              Get.to(DetailsScreen(
                                  movieId: controller.movieSearchList[index]
                                      ['id']));
                            },
                            child: MovieCard(
                                moviesModel: MoviesModel.fromJson(
                                    controller.movieSearchList[index])),
                          ),
                        ),
                      ),
                      if (_isLoadMoreRunning == true)
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 40),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if (_hasNextPage == false)
                        Container(
                          padding: const EdgeInsets.only(top: 30, bottom: 40),
                          color: Colors.amber,
                          child: const Center(
                            child: Text('You have fetched all of the content'),
                          ),
                        ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}
