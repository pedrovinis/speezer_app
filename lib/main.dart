<<<<<<< HEAD
=======
import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
>>>>>>> d510afa64a00d1e0e97995823930a02074bec1b5
import 'package:flutter/material.dart';
import 'package:speezer_app/src/widgets/PlaybackBar.dart';
import 'package:speezer_app/src/widgets/SideBar.dart';

<<<<<<< HEAD
void main() => runApp(const SpeezerApp());

class SpeezerApp extends StatelessWidget {
  const SpeezerApp({super.key});

  @override
=======
import 'package:url_protocol/url_protocol.dart';
import 'package:url_launcher/url_launcher.dart';

const kWindowsScheme = 'speezer';

Future<void> main() async {
  _registerWindowsProtocol();

  await dotenv.load(fileName: '.env');
  runApp(const SpeezerApp());
}

class SpeezerApp extends StatefulWidget {
  const SpeezerApp({super.key});

  @override
  SpeezerAppState createState() => SpeezerAppState();
}

class SpeezerAppState extends State<SpeezerApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      print('getInitialAppLink: $appLink');
      openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    _navigatorKey.currentState?.pushNamed(uri.fragment);
  }

  @override
>>>>>>> d510afa64a00d1e0e97995823930a02074bec1b5
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speezer App',
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.deepPurple,
        highlightColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Arial',
      ),
<<<<<<< HEAD
      home: const SpeezerHome(),
=======
      home: HomeScreen(),
      initialRoute: "/",
      navigatorKey: _navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        Widget routeWidget = HomeScreen();

        final routeName = settings.name;
        if (routeName != null) {
          if (routeName.startsWith('/auth/')) {
            routeWidget = AuthScreen(
              routeName.substring(routeName.indexOf('/auth/')),
            );
          }
        }

        return MaterialPageRoute(
          builder: (context) => routeWidget,
          settings: settings,
          fullscreenDialog: true,
        );
      },
>>>>>>> d510afa64a00d1e0e97995823930a02074bec1b5
    );
  }
}

class SpeezerHome extends StatelessWidget {
  const SpeezerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: false,
          title: const Text(
            'Speezer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Row(
          children: [
            const SideBar(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Playing now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 150.0,
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              'Music $index',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Playlists',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 150.0,
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              'Playlist $index',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: PlaybackBar());
  }
}
