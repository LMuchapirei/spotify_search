import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:spotify_search/search/models/simple_album_object.dart';
import 'package:async/async.dart';
import 'package:spotify_search/search/models/simple_artist_object.dart';

import 'global.dart';

Future<String?> fetchSpotifyToken(String clientId, String clientSecret) async {
  final url = Uri.parse('https://accounts.spotify.com/api/token');
  final authHeader = 'Basic ${base64.encode(utf8.encode('$clientId:$clientSecret'))}';
  
  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(response.body);
      return body['access_token'] as String?;
    } else {
      print('Failed to get token. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error fetching token: $e');
    return null;
  }
}


Future<Result<List<SimplifiedAlbumObject>>> searchSpotifyAlbum(String searchQuery,String searchType) async {
  const String baseUrl = 'https://api.spotify.com/v1/search';
  try{
  final Uri uri = Uri.parse(baseUrl).replace(
    queryParameters: {
      'q': Uri.encodeQueryComponent(searchQuery),
      'type': searchType,
    },
  );
  final accessToken = await Global.storageService.getSpotifyToken();
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $accessToken', 
    },
  );
  if (response.statusCode == 200) {
    final jsonResponseData = jsonDecode(response.body) as Map<String,dynamic>;
    final albumsItems = jsonResponseData["albums"]["items"] as List<dynamic>;
    final albumObjects = albumsItems.map((mapObj) => SimplifiedAlbumObject.fromJson(mapObj)).toList();

    return Result.value(albumObjects);
  } else {
    return Result.error(Exception('Failed to fetch data: ${response.statusCode}'));
   
  }
  } catch(e){
    return Result.error(e);
  }
}

Future<Result<List<SimplifiedArtistObject>>> searchSpotifyArtist(String searchQuery,String searchType) async {
  const String baseUrl = 'https://api.spotify.com/v1/search';
  try{
  final Uri uri = Uri.parse(baseUrl).replace(
    queryParameters: {
      'q': Uri.encodeQueryComponent(searchQuery),
      'type': searchType,
    },
  );
  final accessToken = await Global.storageService.getSpotifyToken();
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $accessToken', 
    },
  );
  if (response.statusCode == 200) {
    final jsonResponseData = jsonDecode(response.body) as Map<String,dynamic>;
    final artistItems = jsonResponseData["artists"]["items"] as List<dynamic>;
    final artistsObject = artistItems.map((mapObj) => SimplifiedArtistObject.fromJson(mapObj)).toList();

    return Result.value(artistsObject);
  } else {
    return Result.error(Exception('Failed to fetch data: ${response.statusCode}'));
   
  }
  } catch(e){
    return Result.error(e);
  }
}


