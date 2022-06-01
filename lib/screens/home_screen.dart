import 'package:cinegenics/components/film_tile.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';
import '../models/film_mini_info.dart';
import 'add_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Info Manager'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<TileData>>(
        valueListenable: Boxes.getTileData().listenable(),
        builder: (context, box, _) {
          final dataTiles = box.values.toList().cast<TileData>();

          return buildContent(dataTiles);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTile(
                  addFunction: addMovie,
                ),
              ),
            );
          }),
    );
  }

  Widget buildContent(List<TileData> movieItems) {
    if (movieItems.isEmpty) {
      return const Center(
        child: Text(
          'No Movies Added yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: movieItems.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = movieItems[index];
                return Dismissible(
                  key: Key(movie.movieId),
                  direction: DismissDirection.endToStart,
                  background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete_forever,
                          color: Colors.white, size: 50.0)),
                  onDismissed: (direction) {
                    deleteTransaction(movie);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${movie.title} deleted')));
                  },
                  child: MovieCard(td: movie),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Future addMovie(TileData td) async {
    final movietile = TileData(
      imageUrl: td.imageUrl,
      movieId: td.movieId,
      title: td.title,
      userRating: td.userRating,
    );

    final box = Boxes.getTileData();
    box.add(movietile);
  }

  void deleteTransaction(TileData movie) {
    movie.delete();
  }
}

//     // ListView.builder(
//     //   itemCount: _tiles.length,
//     //   itemBuilder: (BuildContext context, int index) {
//     //     return FutureBuilder(builder: ((context, snapshot) =>

//     //     ));
//     //   },
//     // ),
//     // FilmTile(
//     //   td: TileData(
//     //       imageUrl:
//     //           "https://image.tmdb.org/t/p/original/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
//     //       title: "Fight Club",
//     //       movieId: "550",
//     //       userRating: 8.4),
//     // ),
// //         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //         floatingActionButton: FloatingActionButton(
// //             onPressed: () {
// //               // Navigator.push(context,
// //               //     MaterialPageRoute(builder: (context) => FileItemScreen()));
// //               setState(() {
// //                 var newMovies = CinegenicsApi.searchFilm(query: "Bhool Bhulaiyaa");
// //                 _tiles.addAll(newMovies);
// //               });
// //             },
// //             child: const Icon(Icons.add)),
// //       ),
// //     );
// //   } 

