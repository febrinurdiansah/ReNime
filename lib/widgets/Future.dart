import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/DataAnime.dart';

class AnimeGet {
  static Future<List<AnimeList>> getAnimeList(String animeGroup) async {
  final response = await http.get(Uri.https('api.consumet.org', '/anime/gogoanime/$animeGroup'));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final List<dynamic> animeDataList = jsonData['results'];

    List<AnimeList> animes = animeDataList.map((eachAnime) {
      return AnimeList(
        id: eachAnime['id'],
        title: eachAnime['title'],
        image: eachAnime['image'],
        // genres: List<String>.from(eachAnime['genres']),
      );
    }).toList();

    return animes;
  } else {
    throw Exception('Failed to load anime');
    }
  }
}