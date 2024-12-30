import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  late final FlutterSecureStorage _secureStorage;

   StorageService init(){
    _secureStorage =  const FlutterSecureStorage();
    return this;
  }

  static const String _spotifyTokenKey = 'spotify_access_token';
  Future<void> saveSpotifyToken(String token) async {
    try {
      await _secureStorage.write(key: _spotifyTokenKey, value: token);
    } catch (e) {
      print('Error saving Spotify token: $e');
    }
  }

  Future<String?> getSpotifyToken() async {
    try {
      final token = await _secureStorage.read(key: _spotifyTokenKey);
      return token;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteSpotifyToken() async {
    try {
      await _secureStorage.delete(key: _spotifyTokenKey);
    } catch (e) {
      print('Error deleting Spotify token: $e');
    }
  }
}
