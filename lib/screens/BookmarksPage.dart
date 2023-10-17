import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/screens/AnimeDetailPage.dart';
import 'package:streaming_app/widgets/RouteAndImage.dart';


class BookmartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: favoriteProvider.favoriteAnime.length,
        itemBuilder: (context, index) {
          final animeInfo = favoriteProvider.favoriteAnime[index];
          final animeId = animeInfo['id'] ?? ''; 
          final animeTitle = animeInfo['title'] ?? ''; 
          final animeImage = animeInfo['image'] ?? '';
          final timestampValue = animeInfo['timestamp'];
          DateTime? timestamp;
          String formattedDateTime = '!Error';
          // function if texttime error // Fungsi jika tulisan waktu error
          if (timestampValue != null) {
            timestamp = DateTime.parse(timestampValue);
            formattedDateTime =
                '${timestamp.day}-${timestamp.month}-${timestamp.year} ${timestamp.hour}:${timestamp.minute}';
          }
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: 375),
            delay: Duration(milliseconds: 120),
            child: Dismissible(
              key: Key(animeTitle),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                final favoriteprovider = Provider.of<FavoriteProvider>(context, listen: false);
                favoriteprovider.toggleFavorite(animeTitle, animeImage, animeId);
                },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(right: 30),
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white,)),
              confirmDismiss: (direction) {
                return showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Confirm?"),
                      content: Text("Are you sure delete it?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                showCloseIcon: false,
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                content: Text("Anime has delete it",
                                  style: TextStyle(
                                    color: Colors.white
                                  )),
                                )
                            );
                          }, 
                          child: Text("Yes", style: TextStyle(color: Colors.red),)
                          ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }, 
                          child: Text("No")
                        ),
                      ],
                    );
                  },
                );
              },
              child: GestureDetector(
                onTap: () {
                  // Map<String, dynamic> detail = Anime[index];
                  Navigator.push(context, createPageRoute(
                  AnimeDetail(
                    getAnimeId: animeId,
                  )
                        )
                    );
                },
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Container(
                      width: double.infinity,
                      height: 90,
                      // color: Colors.amber,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: theme.brightness == Brightness.dark ? Colors.white : Colors.black
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)
                                ),
                              image: DecorationImage(
                                image: NetworkImage(animeImage),
                                fit: BoxFit.cover,
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 150, // Sesuaikan lebar sesuai kebutuhan
                                    child: Text(
                                      animeTitle,
                                      style: TextStyle(fontSize: 17),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formattedDateTime,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}