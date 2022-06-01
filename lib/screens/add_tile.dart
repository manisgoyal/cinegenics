import 'package:cinegenics/api/cinegenics_api.dart';
import 'package:cinegenics/components/film_tile.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class AddTile extends StatefulWidget {
  final Function(TileData td) addFunction;
  const AddTile({
    Key? key,
    required this.addFunction,
  }) : super(key: key);

  @override
  AddTileState createState() => AddTileState();
}

class AddTileState extends State<AddTile> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Center(
    child: Text('Add a Movie'),
  );
  Widget bodyPart = const Center(
    child: Text(
      "Add a movie by using the search bar",
      style: TextStyle(fontSize: 24),
    ),
  );
  final nameController = TextEditingController();

  bool notSearched = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              setState(() {
                if (notSearched) {
                  notSearched = !notSearched;
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: buildName(),
                  );
                } else {
                  notSearched = !notSearched;
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Add a movie');
                }
              });
            },
          )
        ],
      ),
      body: bodyPart,
      floatingActionButton: buildCancelButton(context),
    );
  }

  Widget buildName() => TextField(
        controller: nameController,
        decoration: const InputDecoration(
          hintText: 'type movie name',
          hintStyle: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
        ),
        onSubmitted: (query) {
          var suggestions = CinegenicsApi.searchFilm(query: query);
          setState(() {
            bodyPart = FutureBuilder(
                future: suggestions,
                builder: (context, AsyncSnapshot<List<TileData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        ...snapshot.data!.map((e) => GestureDetector(
                              child: MovieCard(td: e),
                              onTap: () {
                                widget.addFunction(e);
                                Navigator.of(context).pop();
                              },
                            ))
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                });
          });
        },
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );
}
