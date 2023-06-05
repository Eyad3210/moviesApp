import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/book_mark_controller.dart';
import 'package:movie_app/controllers/details_controller.dart';

import '../../main.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.movieId});
  final int movieId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

final MyStorage storage = MyStorage();

class _DetailsScreenState extends State<DetailsScreen> {
  var controller = Get.put(DetailsController());
  var controllerBookmark = Get.put(BookMarkController());

  bool isMark = false;
  final detailsUrl = 'https://api.themoviedb.org/3/movie/';
  @override
  void initState() {
    controller.getMovieDetails(detailsUrl, widget.movieId);
    setState(() {
      isMark = storage.isMark(widget.movieId.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
      
          title: const Text("Movie App"),
          backgroundColor: Colors.red[900],
          leading: GestureDetector(onTap: () {
          Navigator.pop(context);

          }, child: const Icon(Icons.arrow_back)),
        ),
        body: Obx(() => controller.isLoading.value == false
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Image.network(
                          "https://image.tmdb.org/t/p/original/${controller.movieDetails!.backdropPath}",
                          // width: double.infinity,height: 400,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text("loading image");
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                storage.saveData(
                                    "${controller.movieDetails!.id}",
                                    "${controller.movieDetails!.title}");
                                setState(() {
                                  isMark = storage.isMark(
                                      controller.movieDetails!.id.toString());
                                  /////////////////////////
                                 /*  isMark == false
                                      ? controllerBookmark
                                          .delete(controller.movieDetails!.id)
                                      : null; */
                                });
                              },
                              icon: Icon(
                                !isMark ? Icons.star_border : Icons.star,
                                size: 30,
                                color: Colors.blueAccent,
                              )),
                          const Text(
                            "Add To Bookmarks",
                            style: TextStyle(
                                color: Color.fromARGB(255, 33, 150, 243),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      ListTile(
                        title: Text(
                          "${controller.movieDetails!.originalTitle}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("${controller.movieDetails!.overview}"),
                      ),
                      ListTile(
                        title: Text(
                          "budget : ${controller.movieDetails!.budget}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "popularity : ${controller.movieDetails!.popularity}"),
                      ),
                      ListTile(
                        title: Text(
                          "release date : ${controller.movieDetails!.releaseDate}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "revenue : ${controller.movieDetails!.revenue}"),
                      ),
                      ListTile(
                        title: Text(
                          "vote average : ${controller.movieDetails!.voteAverage}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "vote count : ${controller.movieDetails!.voteCount}"),
                      ),
                      ListTile(
                        title: Text(
                          "status : ${controller.movieDetails!.status}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Container(
                          color: Colors.red[200],
                          height: 2,
                          width: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "genres",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Container(
                                  width: 100,
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.indigo[200],
                                  ),
                                  child: Text(
                                      "${controller.movieDetails!.genres![index].name}")),
                            );
                          },
                          itemCount: controller.movieDetails!.genres!.length,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "production companies",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Container(
                                  width: 180,
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blueGrey[200],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                          "${controller.movieDetails!.productionCompanies![index].name}"),
                                      Text(
                                          "${controller.movieDetails!.productionCompanies![index].originCountry}"),
                                    ],
                                  )),
                            );
                          },
                          itemCount: controller
                              .movieDetails!.productionCompanies!.length,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "production countries",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Container(
                                  width: 180,
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.green[200],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                          "${controller.movieDetails!.productionCountries![index].name}"),
                                      Text(
                                          "${controller.movieDetails!.productionCountries![index].iso31661}"),
                                    ],
                                  )),
                            );
                          },
                          itemCount: controller
                              .movieDetails!.productionCountries!.length,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "spoken languages",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Container(
                                  width: 180,
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.blue[200],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                          "${controller.movieDetails!.spokenLanguages![index].name}"),
                                      Text(
                                          "${controller.movieDetails!.spokenLanguages![index].iso6391}"),
                                    ],
                                  )),
                            );
                          },
                          itemCount:
                              controller.movieDetails!.spokenLanguages!.length,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )));
  }
}
