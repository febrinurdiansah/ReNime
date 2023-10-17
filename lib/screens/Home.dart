import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:streaming_app/screens/AboutPage.dart';
import '../models/DataAnime.dart';
import '../widgets/Future.dart';
import '../widgets/Loading.dart';
import 'AnimeDetailPage.dart';
import 'ListRecentAnime.dart';
import 'ListTopAnime.dart';
import 'Setting.dart';
import '../widgets/RouteAndImage.dart';

// AppBar
class AppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  ThemeData theme = Theme.of(context);
  Color textColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
  String getTime = "";
  String getQuots = "";
  int hours = DateTime.now().hour;
    if(hours>=1 && hours<=11){
      getTime = "Good Morning";
      getQuots = "Have a wonderful day!";
    } else if(hours<=15){
      getTime = "Good Afternoon.";
      getQuots = "I hope you're having a great day!";
    } else if(hours<=20){
        getTime = "Good Evening";
        getQuots = "Are you ready for a night of anime?";
    } else if(hours<=24){
        getTime = "Good Night";
        getQuots = "Sweet dreams!";
    }
    return SliverAppBar.large(
      leading: IconButton(
        onPressed: (){
          Scaffold.of(context).openDrawer();
      }, 
      icon: Container(
        height: 35,
        child: Image.asset('images/icons/ic_menu.png',
        color: Color.fromRGBO(0, 119, 182, 1),)
          )
        ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(getTime,style: TextStyle(
            fontSize: 23,
            color: textColor
              ),
          ),
          Text(getQuots,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor
                    ),
                  ),
        ],
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    );
  }
}

class AppBarHome2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color textColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    return SliverAppBar.large(
      leading: IconButton(
        onPressed: (){
          Scaffold.of(context).openDrawer();
      }, 
      icon: Container(
        height: 35,
        child: Text("Re:",
          style: TextStyle(
            fontSize: 28,
            color: Colors.green
          ),)
          )
        ),
      title: Text("nime",style: TextStyle(
            fontSize: 25,
            color: textColor
              ),
          ),
      centerTitle: false,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    );
  }
}


//Main Body from Home Page
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

  bool isLoading = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: isLoading ? CustomScrollView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        controller: _scrollController,
        slivers: [
          AnimatedBuilder(
            animation: _scrollController, 
            builder: (context, child) {
              double offset = _scrollController.position.pixels;
              if (offset > 80){
                return AppBarHome2();
              } else{
                return AppBarHome();
              }
            },
            ),
          SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeroCardItems(),
              TextHome(
                title: "Top Airing",
                nextPage: TopAnimePage(),
              ),
              CardIHome(
                UrlApi: 'top-airing'),
              TextHome(
                title: "Recent Episodes",
                nextPage: RecentAnimePage(),
              ),
              CardIHome(
                UrlApi: 'recent-episodes'),
            ],
          ),
          ),
        ],
      ) : LoadingHomeWidget(),
    );
  }
}

class DrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 150,
      shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20)
              )
            ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(createPageRoute(SettingPage()));
                },
                child: Text("Setting")
                ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(createPageRoute(AboutPage()));
                },
                child: Text("About App")
                ),
            ],
          ),
        ),
      );
  }
}
// Hero in Home
class HeroCardItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.primary;
    return Container(
      height: 250,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Swiper(
        scrollDirection: Axis.horizontal,
        itemCount: Anime.length,
        scale: 0.9,
        itemBuilder: (context, index) {
          var animeItem = Anime[index];
          final List myGenre = animeItem['genre'];
          final String myImage = animeItem['image'];
          final String myJudul = animeItem['judul'];
          return Bounceable(
            onTap: () {
              // Map<String, dynamic> detail = Anime[index];
              // Navigator.push(context, createPageRoute(
              //   AnimeDetail()
              //   )
              // );
          },
            child: Card(
              margin: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              // shadowColor: Colors.black,
              elevation: 3,
              child: Column(
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage(myImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              width: 300,
                              bottom: 10,
                              left: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myJudul,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: myGenre.take(5).map((genre) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                        margin: EdgeInsets.only(right: 5, top: 5),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).chipTheme.backgroundColor,
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                        ),
                                        child: Text(genre,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textColor
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Text in Home
class TextHome extends StatelessWidget {
  final String title;
  final Widget nextPage;
  
  TextHome({required this.title, required this.nextPage}); 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(
                fontSize: 18,
                fontFamily: 'OpenSans',
                      ),
              ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, createPageRoute(nextPage)
                    );
              },
              child: Text(
                "All",
                style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'OpenSans',
                  decoration: TextDecoration.none,
                  color: Colors.lightBlue
                ),
              ),
            ),
        ],
      ),
    );
  }
}

//Card List
class CardIHome extends StatelessWidget {
  final String UrlApi ;

  const CardIHome({super.key, required this.UrlApi});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.primary;
    return Container(
      height: 230,
      child: FutureBuilder(
        future: AnimeGet.getAnimeList(UrlApi), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingListHome();
            } else if (snapshot.hasError) {
              // return Text('Error: ${snapshot.error}');
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 150,
                      child: Image.asset('images/no-connection.png'),
                    ),
                    Text('No Connection',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary
                      ),)
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 80,
                      child: Image.asset('images/no-connection.png'),
                    ),
                    Text('No Connection',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary
                      ),)
                  ],
                ),
              );
            }
            final animeList = snapshot.data!;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Bounceable(
                  onTap: () {
                    // Map<String, dynamic> detail = Anime[index];

                    Navigator.push(context, createPageRoute(
                      AnimeDetail(
                        getAnimeId: animeList[index].id
                        )
                        )
                      );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.only(left: 10,bottom: 15,top: 15),
                    shape: Theme.of(context).cardTheme.shape,
                    shadowColor: Colors.black,
                    elevation: 3,
                    child: Row(
                      children: [
                        Container(
                            width: 120,
                            child: Column(
                              children: [
                                Container(
                                  height: 160,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                    image: DecorationImage(
                                      image: NetworkImage(animeList[index].image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(animeList[index].title, 
                                      style: TextStyle(
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                        color: textColor
                                      ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
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