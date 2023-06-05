
import 'package:flutter/material.dart';
import 'package:movie_app/models/movies_model.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.moviesModel});
  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(moviesModel.originalTitle.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
            subtitle: Text(moviesModel.overview.toString()),
          ),
          ListTile(
            title:moviesModel.posterPath!=null? Image.network(
              "https://image.tmdb.org/t/p/original/${moviesModel.posterPath}",
              width: double.infinity,height: 400,
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
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ):const Text("No image"),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("Release Date : ${moviesModel.releaseDate}"),
                        ),

          ),
          ListTile(
            title: Text("Vote Average : ${moviesModel.voteAverage}",style: const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Vote Count : ${moviesModel.popularity}"),
          ),
        ],
      ),
    );
  }
}