import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speezer_app/src/widgets/PlaybackBar.dart';
import 'package:speezer_app/src/widgets/SideBar.dart';
import 'package:speezer_app/src/widgets/SpotifyIntegration.dart';

void main() {
  if (kIsWeb) {
    handleSpotifyAuthRedirect();
  }

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
            SpotifyIntegration(),

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

Future<void> handleSpotifyAuthRedirect() async {
  final Uri initialUri = Uri.parse(window.location.href);
  final Uri redirectUri = Uri.parse('YOUR_REDIRECT_URI');

  if (initialUri.fragment.isNotEmpty && initialUri != redirectUri) {
    // Redirected from Spotify authentication
    // Extract access token from the URL fragment
    final queryParams = Uri.splitQueryString(initialUri.fragment);
    final accessToken = queryParams['access_token'];

    // Perform further processing with the access token
    // For example, store it in local storage or pass it to your authentication handler
  }
}
