import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/Future.dart';
import '../widgets/Loading.dart';
import '../widgets/RouteAndImage.dart';
import 'AnimeDetailPage.dart';

class TopAnimePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Airing",style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Color.fromRGBO(97, 224, 255, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_rounded, color: Colors.black,)),
      ),
      body: FutureBuilder(
        future: AnimeGet.getAnimeList('top-airing'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingListAnime();
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
            final animeTop = snapshot.data!;

            return ListView.builder(
            itemCount: animeTop.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 375),
                delay: Duration(milliseconds: 120),
                child: GestureDetector(
                  onTap: () {
                    // Map<String, dynamic> detail = Anime[index];
                  Navigator.push(context, createPageRoute(
                    AnimeDetail(
                      getAnimeId: animeTop[index].id
                    )
                  )
                  );
                  },
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 110,
                                height: 130,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: NetworkImage(animeTop[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 190,
                                        child: Text(
                                          animeTop[index].title,
                                          style: TextStyle(
                                            fontSize: 19,
                                            ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //   animeTop[index].genres.take(3).join(', '),
                                        //   style: TextStyle(fontSize: 11),
                                        // ),
                                      ]
                                    )
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
          );
        },
      ),
    );
  }
}