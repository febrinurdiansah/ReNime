import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class LoadingHomeWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color color1 = isDarkMode ? Color.fromARGB(255, 28, 28, 28) : Color(0xFFE5E5E5);
    Color color2 = isDarkMode ? Color.fromARGB(255, 56, 56, 56) : Color(0xFFF0F0F0);
    return CardLoading(
          height: 250,
          margin: EdgeInsets.all(15),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: color1, 
            colorTwo: color2
            )
    );
  }
}

class LoadingListHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color color1 = isDarkMode ? Color.fromARGB(255, 28, 28, 28) : Color(0xFFE5E5E5);
    Color color2 = isDarkMode ? Color.fromARGB(255, 56, 56, 56) : Color(0xFFF0F0F0);
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: List.generate(3, (index) {
          return CardLoading(
            height: 120,
            width: 100,
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            cardLoadingTheme: CardLoadingTheme(
              colorOne: color1, 
              colorTwo: color2
              )
          );
        }),
      ),
    );
  }
}

class LoadingSrcWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color color1 = isDarkMode ? Color.fromARGB(255, 28, 28, 28) : Color(0xFFE5E5E5);
    Color color2 = isDarkMode ? Color.fromARGB(255, 56, 56, 56) : Color(0xFFF0F0F0);
    return Column(
      children: [
        Column(
          children: List.generate(2, (index) {
            return Row(
              children: [
                CardLoading(
                  height: 190,
                  width: 160,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  cardLoadingTheme: CardLoadingTheme(
                    colorOne: color1, 
                    colorTwo: color2
                      )
                    ),
                CardLoading(
                  height: 190,
                  width: 160,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  cardLoadingTheme: CardLoadingTheme(
                    colorOne: color1, 
                    colorTwo: color2
                      )
                    ),
                  ],
                );
              })
            ),
        Row(
          children: [
            CardLoading(
                  height: 104,
                  width: 160,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                    ),
                  cardLoadingTheme: CardLoadingTheme(
                    colorOne: color1, 
                    colorTwo: color2
                    )
                  ),
            CardLoading(
                  height: 104,
                  width: 160,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                    ),
                  cardLoadingTheme: CardLoadingTheme(
                    colorOne: color1, 
                    colorTwo: color2
                    ),
                  ),
          ],
        )
      ],
    );
  }
}

class LoadingAnimeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color color1 = isDarkMode ? Color.fromARGB(255, 28, 28, 28) : Color(0xFFE5E5E5);
    Color color2 = isDarkMode ? Color.fromARGB(255, 56, 56, 56) : Color(0xFFF0F0F0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardLoading(
          height: 300,
          margin: EdgeInsets.only(bottom: 10),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: color1, 
            colorTwo: color2
            ),
        ),
        CardLoading(
          height: 40,
          width: 80,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          margin: EdgeInsets.only(bottom: 10, left: 15),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: color1, 
            colorTwo: color2
            ),
        ),
        CardLoading(
          height: 10,
          width: 150,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          margin: EdgeInsets.only(bottom: 10, left: 15),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: color1, 
            colorTwo: color2
            ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15,bottom: 10),
          child: Row(
            children: List.generate(6, (index) {
              return CardLoading(
                height: 20,
                width: 40,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                margin: EdgeInsets.only(left: 5,right: 5),
                cardLoadingTheme: CardLoadingTheme(
                  colorOne: color1, 
                  colorTwo: color2
                  ),
                );
            }),
          ),
        ),
        CardLoading(
          height: 130,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: color1, 
            colorTwo: color2
            ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15,bottom: 10),
          child: Row(
            children: List.generate(6, (index) {
              return CardLoading(
                height: 45,
                width: 45,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                margin: EdgeInsets.only(left: 5,right: 5),
                cardLoadingTheme: CardLoadingTheme(
                  colorOne: color1, 
                  colorTwo: color2
                  ),
                );
            }),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15,bottom: 10),
          child: Row(
            children: List.generate(6, (index) {
              return CardLoading(
                height: 45,
                width: 45,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                margin: EdgeInsets.only(left: 5,right: 5),
                cardLoadingTheme: CardLoadingTheme(
                  colorOne: color1, 
                  colorTwo: color2
                  ),
                );
            }),
          ),
        ),
      ],
    );
  }
}

class LoadingListAnime extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color color1 = isDarkMode ? Color.fromARGB(255, 28, 28, 28) : Color(0xFFE5E5E5);
    Color color2 = isDarkMode ? Color.fromARGB(255, 56, 56, 56) : Color(0xFFF0F0F0);
    return Column(
      children: List.generate(4, (index) {
        return Row(
          children: [
            CardLoading(
              height: 130,
              width: 110,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              cardLoadingTheme: CardLoadingTheme(
                  colorOne: color1, 
                  colorTwo: color2
                  ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardLoading(
                  height: 20,
                  width: 80,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  margin: EdgeInsets.only(bottom: 15),
                  cardLoadingTheme: CardLoadingTheme(
                    colorOne: color1, 
                    colorTwo: color2
                    ),
                  ),
                Row(
                  children: List.generate(4, (index) {
                    return CardLoading(
                      height: 15,
                      width: 30,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      margin: EdgeInsets.only(right: 5),
                      cardLoadingTheme: CardLoadingTheme(
                        colorOne: color1, 
                        colorTwo: color2
                        ),
                      );
                  }),
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}