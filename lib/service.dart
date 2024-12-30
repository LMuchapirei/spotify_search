import 'dart:convert'; // For base64 encoding and decoding
import 'package:http/http.dart' as http;

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


