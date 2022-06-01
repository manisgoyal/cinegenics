import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import 'config.dart';

class CinegenicsApi {
  static const apiKey = Config.apiKey;

  static Future<List<TileData>> searchFilm({required String query}) async {
    final url =
        "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query";
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> searchResp = jsonDecode(response.body);
    final List<dynamic> searchresults = searchResp["results"];
    return <TileData>[
      ...searchresults.map((e) => TileData.fromJson(e)),
    ];
  }
}
