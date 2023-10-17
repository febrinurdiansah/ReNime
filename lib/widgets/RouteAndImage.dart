import 'package:flutter/material.dart';

PageRouteBuilder createPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class ImageAnnouncement extends StatelessWidget {
  final String imageAsset;
  final String textAnnouncement;

  const ImageAnnouncement({super.key, required this.imageAsset, required this.textAnnouncement});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 280,
            child: Image.asset(imageAsset),
          ),
          Text(textAnnouncement,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary
            ),)
        ],
      ),
    );
  }
}