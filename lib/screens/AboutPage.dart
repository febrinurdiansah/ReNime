import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    margin: EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage('images/icons/ic_app.webp'),
                        fit: BoxFit.cover
                        )
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Re',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(
                          text: ':nime',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('This app is your gateway to the world of anime. Enjoy your favorite anime shows and movies anytime, anywhere with this user-friendly streaming platform.',
                  textAlign: TextAlign.center,
                  ),
                ],
              ),
              VersionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class VersionWidget extends StatefulWidget {

  @override
  State<VersionWidget> createState() => _VersionWidgetState();
}

class _VersionWidgetState extends State<VersionWidget> {
  String version = "";

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  Future<void> _getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Text("Version App: $version");
  }
}