import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:movie_app/controllers/movies_controller.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/services/crud.dart';
import '../details_screen/details_screen.dart';
import '../widgets/movie_card.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  var controller = Get.put(MoviesController());
  final _baseUrl = 'https://api.themoviedb.org/3/movie/popular';
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

      var res = await controller.crud.getRequest("$_baseUrl?page=$_page");
      //var res=await controller.getMovies("$_baseUrl?page=$_page");
      var list = jsonDecode(res);

      if (list != null) {
        setState(() {
          controller.moviesList.addAll(list['results']);
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

    controller.getMovies("$_baseUrl?page=$_page");

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _firstLoad();
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
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.moviesList.length,
                          controller: _controller,
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              Get.to(DetailsScreen(
                                movieId: controller.moviesList[index]['id'],
                              ));
                            },
                            child: MovieCard(
                                moviesModel: MoviesModel.fromJson(
                                    controller.moviesList[index])),
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
