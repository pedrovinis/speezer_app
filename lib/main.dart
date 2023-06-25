import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speezer_app/src/widgets/PlaybackBar.dart';
import 'package:speezer_app/src/widgets/SideBar.dart';
import 'package:spotify/spotify.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:window_manager/window_manager.dart';

const kWindowsScheme = 'sample';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setSize(const Size(600, 400));
      await windowManager.center();
      await windowManager.show();
    });

    await protocolHandler.register('speezer');
  }
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
      home: HomeScreen(),
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        Widget routeWidget = HomeScreen();

        // Mimic web routing
        final routeName = settings.name;
        if (routeName != null) {
          if (routeName.startsWith('/book/')) {
            // Navigated to /book/:id
            routeWidget = AuthScreen(
              routeName.substring(routeName.indexOf('/book/')),
            );
          } else if (routeName == '/book') {
            // Navigated to /book without other parameters
            routeWidget = AuthScreen("None");
          }
        }

        return MaterialPageRoute(
          builder: (context) => routeWidget,
          settings: settings,
          fullscreenDialog: true,
        );
      },
    );
  }

  Widget HomeScreen() {
    final clientId = dotenv.env['SPOTIFY_CLIENT_ID'].toString();
    final clientSecret = dotenv.env['SPOTIFY_CLIENT_SECRET'].toString();
    final credentials = SpotifyApiCredentials(clientId, clientSecret);

    final spotify = SpotifyApi(credentials);

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
            ElevatedButton(
                onPressed: () => spotifyAuth(credentials), child: null),
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

  Widget AuthScreen(String authToken) {
    return const Column(
      children: [Text("authToken")],
    );
  }
}

Future<void> spotifyAuth(SpotifyApiCredentials credentials) async {
  final redirectUri = dotenv.env['SPOTIFY_REDIRECT_URL'].toString();
  final grant = SpotifyApi.authorizationCodeGrant(credentials);

  final scopes = ['user-read-email', 'user-library-read'];

  final authUri = grant.getAuthorizationUrl(
    Uri.parse(redirectUri),
    scopes: scopes,
  );

  await launchUrl(
    Uri.parse(authUri.toString()),
    webOnlyWindowName: '_self',
  );
}

void _registerWindowsProtocol() {
  // Register our protocol only on Windows platform
  if (!kIsWeb) {
    if (Platform.isWindows) {
      // registerProtocolHandler(kWindowsScheme);
    }
  }
}
