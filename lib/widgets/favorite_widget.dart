import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controller/home_controller.dart';
import 'package:movies/screens/movie_details_screen.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return controller.favoriteMovies.isEmpty
        ? const Center(child: Text("No Favorite!"))
        : ListView.builder(
            itemCount: controller.favoriteMovies.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(() => MovieDetailsScreen(
                      movieId: controller.favoriteMovies[index].id));
                },
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // the Title of movie
                          Container(
                            // width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              controller.favoriteMovies[index].title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          // the voteAverage
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                margin: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: const Text("IMDB",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey)),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                  "${controller.favoriteMovies[index].voteAverage}",
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                      // image of movie
                      Container(
                        width: MediaQuery.of(context).size.height * .1,
                        height: MediaQuery.of(context).size.height * .08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${controller.favoriteMovies[index].backdropPath}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
