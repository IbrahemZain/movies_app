import 'package:flutter/material.dart';
import 'package:movies/screens/movie_details_screen.dart';
import '../models/movie_model.dart';
import 'package:get/get.dart';
import 'package:movies/controller/home_controller.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final HomeController controller = Get.put(HomeController());
  bool isLoading = false;

  List<MovieModel> nowPlayingMoviesList = [];

  @override
  void initState() {
    getNowPlayingMovies();
    super.initState();
  }

  getNowPlayingMovies() async {
    setState(() {
      isLoading = true;
    });
    nowPlayingMoviesList = await controller.getNowPlayingMovies();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Searching
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: TextField(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: 'Search',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            maxLines: 1,
          ),
        ),
        // Text Now playing
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(15),
          child: const Text(
            "Now Playing",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textDirection: TextDirection.ltr,
          ),
        ),
        // List of movies
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: DummyMovies().dummyMovies.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => MovieDetailsScreen(
                            movieId: nowPlayingMoviesList[index].id));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * .9,
                        child: Card(
                          child: Column(
                            children: [
                              //image of movie
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${nowPlayingMoviesList[index].backdropPath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // the voteAverage
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
                                            fontSize: 10, color: Colors.grey)),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                      "${nowPlayingMoviesList[index].voteAverage}",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // the Title of movie
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  nowPlayingMoviesList[index].title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
