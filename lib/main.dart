import 'package:flutter/material.dart';
import 'package:speezer_app/src/widgets/PlaybackBar.dart';
import 'package:speezer_app/src/widgets/SideBar.dart';
import 'package:spotify/spotify.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:html' as html;

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const SpeezerApp());
}

class SpeezerApp extends StatelessWidget {
  const SpeezerApp({super.key});

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
      home: const SpeezerHome(),
    );
  }
}

class SpeezerHome extends StatelessWidget {
  const SpeezerHome({super.key});

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(onPressed: () => spotifyAuth(credentials), child: null),
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

Future<void> spotifyAuth(SpotifyApiCredentials credentials) async {
  final redirectUri = dotenv.env['SPOTIFY_REDIRECT_URL'].toString();
  final grant = SpotifyApi.authorizationCodeGrant(credentials);

  final scopes = ['user-read-email', 'user-library-read'];

  final authUri = grant.getAuthorizationUrl(
    Uri.parse(redirectUri),
    scopes: scopes,
  );

  html.window.open(authUri.toString(), 'Auth', 'width: 500, height: 500').addEventListener("", (event) => null);
}
