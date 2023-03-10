import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controller/home_controller.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/models/movie_detail_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final HomeController controller = Get.put(HomeController());
  bool isLoading = false;
  late MovieDetailModel movieDetails;
  late GenresModel genresModel;
  List<String> genresTitle = [];
  bool isFavorite = false;

  @override
  void initState() {
    getMovieDetails();
    super.initState();
  }

  getMovieDetails() async {
    setState(() {
      isLoading = true;
    });
    movieDetails = await controller.getMovieDetails(widget.movieId);
    getGenresOfMovie();
    getFavoriteState();
    setState(() {
      isLoading = false;
    });
  }

  getGenresOfMovie() {
    movieDetails.genres.forEach((element) {
      genresTitle.add(element.name);
    });
  }

  getFavoriteState() {
    isFavorite = controller.isFavorite(movieDetails)!;
    print("##################$isFavorite");
  }

  addToFavorite(){
    if(isFavorite == false){
      setState(() {
        isFavorite = true;
      });
      controller.addToFavorite(movieDetails);
    }else if (isFavorite == true){
      setState(() {
        isFavorite = false;
      });
      controller.favoriteMovies.removeWhere((element) => element.id == movieDetails.id,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: ListView(
                children: [
                  Container(
                    // padding: const EdgeInsets.all(10),
                    // width: MediaQuery.of(context).size.width * .9,
                    child: Card(
                      child: Column(
                        children: [
                          //image of movie
                          Container(
                            height: MediaQuery.of(context).size.height * .73,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // the voteAverage
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: const EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: const Text("IMDB",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey)),
                                  ),
                                  const SizedBox(width: 10),
                                  Text("${movieDetails.voteAverage}",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ],
                              ),
                              // favorite button
                              IconButton(
                                onPressed: addToFavorite,
                                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // the Title of movie
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              movieDetails.title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          // Release Date of movie
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: const Text(
                                  "Release Date:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  movieDetails.releaseDate,
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.black54),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ],
                          ),
                          // Story of movie
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            child: const Text(
                              "Story",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              movieDetails.overview,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black54),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          // genres of movie
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            child: const Text(
                              "Genres:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              genresTitle.toString(),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black54),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
