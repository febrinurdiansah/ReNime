import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/models/DataAnime.dart';
import 'package:streaming_app/widgets/RouteAndImage.dart';
import 'dart:convert';
import '../widgets/Loading.dart';
import 'VideoPage.dart';
import 'package:http/http.dart' as http;

class AnimeDataProvider {
  static Future<AnimeInfo> getAnimeInfo(String animeId) async {
    try {
      final response = await http.get(
        Uri.https('api.consumet.org', '/anime/gogoanime/info/$animeId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> animeData = json.decode(response.body);
        return AnimeInfo(
          id: animeData['id'],
          title: animeData['title'],
          url: animeData['url'],
          releaseDate: animeData['releaseDate'],
          image: animeData['image'],
          description: animeData['description'],
          othertitle: animeData['otherName'],
          status: animeData['status'],
          genre: List<String>.from(animeData['genres']),
          type: animeData['type'],
          totalEpisodes: animeData['totalEpisodes'],
        );
      } else {
        throw Exception('Failed to load anime info');
      }
    } catch (error) {
      throw Exception('Failed to load anime info: $error');
    }
  }
}

class AnimeDetail extends StatelessWidget {
  final String getAnimeId;

  const AnimeDetail({super.key, required this.getAnimeId});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<AnimeInfo>(
        future: AnimeDataProvider.getAnimeInfo(getAnimeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingAnimeWidget();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
              // return ImageAnnouncement(
              //   imageAsset: 'images/no-connection.png', 
              //   textAnnouncement: 'No Connection');
            } else if (!snapshot.hasData) {
              return ImageAnnouncement(
                imageAsset: 'images/no-found.png', 
                textAnnouncement: 'No Found');
            }
            final animeData = snapshot.data!;

            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  backgroundColor: Colors.transparent,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${animeData.image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Consumer<FavoriteProvider>(
                      builder: (context, favoriteprovider, _) {
                        return FavoriteWiget(
                          favoriteprovider: favoriteprovider, 
                          detailAnim: animeData, 
                          );
                      },
                      )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleAndEpsWidget(detailAnim: animeData,),
                      Description(detailAnim: animeData,),
                      Container(
                        height: 30,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Epiosde",
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            color: textColor
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ScrollEpsWidget(detailAnim: animeData,)
              ],
            );
        },
      )
    );
  }
}

class TitleAndEpsWidget extends StatelessWidget {
  final AnimeInfo detailAnim;
  const TitleAndEpsWidget({required this.detailAnim});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.primary;
    return Container(
        width: double.infinity,
        // height: 110,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title Anime
            Text(
              "${detailAnim.title}",
              style: TextStyle(
                fontSize: 24,
                decoration: TextDecoration.none,
                overflow: TextOverflow.ellipsis,
                color: textColor
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "${detailAnim.totalEpisodes} Episode | ${detailAnim.status} | ${detailAnim.releaseDate}",
                  style: TextStyle(
                    fontSize: 11,
                    decoration: TextDecoration.none,
                    color: textColor
                    )
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Wrap(
                  spacing: 4, 
                  runSpacing: 6, 
                  children: [
                    for (var item in detailAnim.genre) Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).chipTheme.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        "$item",
                        style: TextStyle(
                          fontSize: 10,
                          color: textColor,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                  ]),
            )
          ],
        ));
  }
}

class ScrollEpsWidget extends StatelessWidget {
  final AnimeInfo detailAnim;
  const ScrollEpsWidget({required this.detailAnim});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.primary;
    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6, 
          crossAxisSpacing: 5, 
          mainAxisSpacing: 5,
        ),
        itemCount: detailAnim.totalEpisodes,
        itemBuilder: (context, index) {
          int eps = index + 1;
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return VideoPage(
                    idAnime: detailAnim.id,
                    Eps: eps,
                  );
                },
                ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(width: 1, color: textColor),
              ),
              child: Center(
                child: Text('$eps',
                    style: TextStyle(
                      color: textColor
                    ),),
              ),
            ),
          );
        },
    );
  }
}

class FavoriteWiget extends StatefulWidget {
  final AnimeInfo detailAnim;
  const FavoriteWiget({
    required this.favoriteprovider,
    required this.detailAnim
  });

  final FavoriteProvider favoriteprovider;

  @override
  State<FavoriteWiget> createState() => _FavoriteWigetState();
}

class _FavoriteWigetState extends State<FavoriteWiget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          widget.favoriteprovider.toggleFavorite(
            widget.detailAnim.title,
            widget.detailAnim.image,
            widget.detailAnim.id,
          );
        },
        child: Image.asset(widget.favoriteprovider.favoriteAnime.any(
          (element) => element['title'] == widget.detailAnim.title)
        ? 'images/icons/ic_heart.png' 
        : 'images/icons/ic_unheart.png',
        height: 35,
        width: 35,
        color: Colors.red,
        ),
      ),
    );
  }
}

class FavoriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> favoriteAnime = [];
  late SharedPreferences _prefs;
  FavoriteProvider() {
    _init();
  }

  void _init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFromPrefs(); // Ganti _init dengan _loadFromPrefs
  }

  void _loadFromPrefs() {
    final favoriteAnimeJson = _prefs.getStringList('favoriteAnime');
    favoriteAnime = favoriteAnimeJson
        ?.map((animeJson) => json.decode(animeJson))
        .cast<Map<String, dynamic>>()
        .toList() ?? [];
    notifyListeners();
  }

  void _saveToPrefs() {
    final favoriteAnimeJson =
        favoriteAnime.map((anime) => json.encode(anime)).toList();
    _prefs.setStringList('favoriteAnime', favoriteAnimeJson);
    _loadFromPrefs(); // Perbarui data favorit setiap kali disimpan
  }

  void toggleFavorite(String animeTitle, String animeImage, String animeId) {
    var existingIndex = favoriteAnime.indexWhere((element) => element['title'] == animeTitle);

    if (existingIndex != -1) {
      favoriteAnime.removeAt(existingIndex);
    } else {
      favoriteAnime.add({
        'id': animeId,
        'title': animeTitle,
        'image': animeImage,
        'timestamp': DateTime.now().toIso8601String(), // Menyimpan waktu saat ditambahkan ke favorit
      });
    }
    _saveToPrefs();
    notifyListeners();
  }
}


class Description extends StatefulWidget {
  final AnimeInfo detailAnim;
  const Description({required this.detailAnim});
  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool _showFullText = true;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.primary;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sinopsis",
            style: TextStyle(
              fontSize: 14,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w900,
              color: textColor
            ),
          ),
          SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.detailAnim.description,
                maxLines: _showFullText ? 3 : 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  decoration: TextDecoration.none,
                  color: textColor
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showFullText = !_showFullText;
                  });
                },
                child: Center(
                    child: Icon(_showFullText
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_up_rounded,
                        color: textColor),
                        ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}
