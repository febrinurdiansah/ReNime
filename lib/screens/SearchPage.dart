import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:streaming_app/screens/AnimeDetailPage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/Future.dart';
import '../widgets/Loading.dart';
import '../widgets/RouteAndImage.dart';
import 'package:http/http.dart' as http;


// Body search page
class SearchPage extends StatefulWidget {

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredAnime = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> searchAnime(String text) async {
  try {
    setState(() {
      isSearching = true;
    });
    final response = await http.get(
      Uri.https('api.consumet.org', '/anime/gogoanime/$text'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> animeList = responseData['results'];

      setState(() {
        filteredAnime = animeList.cast<Map<String, dynamic>>();
        isSearching = false; // Nonaktifkan pencarian setelah selesai
      });
    } else {
      throw Exception('Failed to load anime');
    }
  } catch (error) {
    print('Error searching anime: $error');
    setState(() {
      isSearching = false; // Nonaktifkan pencarian jika terjadi kesalahan
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        //Search title anime
        SliverSafeArea(
            sliver: SliverAppBar(
            expandedHeight: 60,
            pinned: true,
            backgroundColor: Theme.of(context).cardColor,
            flexibleSpace: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: SearchBarAnimation(
                textEditingController: _searchController,
                isOriginalAnimation: false,
                enableKeyboardFocus: true,
                onChanged: (text) {
                  // Tidak perlu melakukan apa-apa di sini, karena kita akan menangani pencarian pada onFieldSubmitted
                },
                onFieldSubmitted: (text) {
                  searchAnime(text);
                },
                hintText: 'Search',
                trailingWidget: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.black,
                ),
                secondaryButtonWidget: const Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.black,
                ),
                buttonWidget: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.black,
                ),
                ),
              )
            ),
          ),
        ),
        
        //If anime doesn't exist // Jika anime tidak ada 
        SliverToBoxAdapter(
  child: isSearching ? Center(child: LoadingSrcWidget())
      : filteredAnime.isEmpty
      ? ListSearchDataAnime()
      : CardAnime(filteredAnime),
  )

          ],
        );
  }
}

class CardAnime extends StatelessWidget {
  final List<Map<String, dynamic>> animeList;

  CardAnime(this.animeList);

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    final int columnCount = 2;
    final double itemHeight = 230;
    final double itemWidth = MediaQuery.of(context).size.width / columnCount;
    Color textColor = Theme.of(context).colorScheme.primary;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: (itemWidth / itemHeight),
      ),
      controller: _controller,
      padding: EdgeInsets.all(10),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: animeList.length, // Menggunakan animeList yang diberikan
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: columnCount,
          duration: Duration(milliseconds: 375),
          delay: Duration(milliseconds: 275),
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: Container(
                height: itemHeight,
                child: Bounceable(
                  onTap: () {
                    // Map<String, dynamic> detail = Anime[index];
                    Navigator.push(context, createPageRoute(
                      AnimeDetail(
                        getAnimeId: animeList[index]['id']
                        ))
                      );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    shape: Theme.of(context).cardTheme.shape,
                    shadowColor: Colors.black,
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 165,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(animeList[index]['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Text(
                              animeList[index]['title'], // Menggunakan data dari animeList
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListSearchDataAnime extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    final int columnCount = 2;
    final double itemHeight = 230;
    final double itemWidth = MediaQuery.of(context).size.width / columnCount;
    Color textColor = Theme.of(context).colorScheme.primary;
    return FutureBuilder(
      future: AnimeGet.getAnimeList('top-airing'), //link mengarah ke semua anime, kalo bisa
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingSrcWidget();
            } else if (snapshot.hasError) {
              // return Text('Error: ${snapshot.error}');
              return ImageAnnouncement(
                imageAsset: 'images/no-connection.png', 
                textAnnouncement: 'No Connection');
            } else if (!snapshot.hasData) {
              return ImageAnnouncement(
                imageAsset: 'images/no-found.png', 
                textAnnouncement: 'No Found');
            }
            final dataAnime = snapshot.data!;

            return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            controller: _controller,
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: dataAnime.length,
            addAutomaticKeepAlives: true,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: columnCount,
                duration: Duration(milliseconds: 375),
                delay: Duration(milliseconds: 275),
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Container(
                      height: itemHeight,
                      child: Bounceable(
                        onTap: () {
                          // Map<String, dynamic> detail = Anime[index];
                          Navigator.push(context, createPageRoute(
                            AnimeDetail(
                              getAnimeId: dataAnime[index].id,
                            )
                            )
                          );
                        },
                        child: Card(
                          color: Theme.of(context).cardColor,
                          shape: Theme.of(context).cardTheme.shape,
                          shadowColor: Colors.black,
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 165,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(dataAnime[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: Text(dataAnime[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: textColor
                                      ),
                                  )
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
  }
}

