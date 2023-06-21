import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SpotifyIntegration extends StatefulWidget {
  @override
  _SpotifyIntegrationState createState() => _SpotifyIntegrationState();
}

class _SpotifyIntegrationState extends State<SpotifyIntegration> {
  final String clientId = '6880b271a3a14f028b8dc5c25c9c210f';
  final String redirectUri = 'http://localhost:60677/';
  final String scope = 'user-read-email';

  String _accessToken = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _authenticateWithSpotify();
        },
        child: const Text('Authenticate with Spotify'),
      ),
    );
  }

  Future<void> _authenticateWithSpotify() async {
    final String authUrl =
        'https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=$scope&response_type=token';

    if (await canLaunch(authUrl)) {
      await launch(authUrl, forceSafariVC: false, forceWebView: false);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to launch Spotify authentication'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _handleRedirect(Uri uri) async {
    if (uri.fragment != null) {
      final queryParams = Uri.splitQueryString(uri.fragment);
      if (queryParams.containsKey('access_token')) {
        final accessToken = queryParams['access_token'];
        setState(() {
          _accessToken = accessToken!;
        });

        _fetchUserProfile();
      }
    }
  }

  Future<void> _fetchUserProfile() async {
    final profileEndpoint = Uri.parse('https://api.spotify.com/v1/me');

    final response = await http.get(
      profileEndpoint,
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (response.statusCode == 200) {
      final userProfile = jsonDecode(response.body);
      final displayName = userProfile['display_name'];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Profile'),
            content: Text('Logged in as: $displayName'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch user profile'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
