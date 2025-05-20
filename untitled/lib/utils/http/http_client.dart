import 'dart:convert';
import 'package:http/http.dart' as http;  // Corrected the import.

class THttpHelper {
  static const String _baseUrl = 'https://your-api-base-url.com';

  // GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));

      return _handleResponse(response);
    } catch (e) {
      // Handle any connection errors or other issues
      return {'error': 'Failed to load data: $e'};
    }
  }

  // POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      // Handle any connection errors or other issues
      return {'error': 'Failed to send data: $e'};
    }
  }

  // Handle the HTTP response (error handling and parsing)
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the server returns a successful response, parse the JSON
      try {
        return json.decode(response.body);
      } catch (e) {
        return {'error': 'Failed to parse response: $e'};
      }
    } else {
      // If the server returns an error, return the error details
      return {'error': 'Request failed with status: ${response.statusCode}'};
    }
  }
}
