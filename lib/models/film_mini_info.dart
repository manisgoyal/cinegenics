import 'package:hive/hive.dart';

part 'film_mini_info.g.dart';

@HiveType(typeId: 0)
class TileData extends HiveObject {
  @HiveField(0)
  String imageUrl;
  @HiveField(1)
  String title;
  @HiveField(2)
  String movieId;
  @HiveField(3)
  double userRating;

  TileData(
      {required this.imageUrl,
      required this.title,
      required this.movieId,
      required this.userRating});

  factory TileData.fromJson(Map<String, dynamic> json) {
    return TileData(
      imageUrl: "https://image.tmdb.org/t/p/original${json["poster_path"]}",
      title: json["title"],
      movieId: json["id"].toString(),
      userRating: json["vote_average"].toDouble(),
    );
  }
}
