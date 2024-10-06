import 'package:inditab_task_flutter/models/user_modal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String apiUrl =
      'https://ixifly.in/flutter/task2'; // Base URL for the API

  // Method to fetch user data from the API
  static Future<Users> getUserData() async {
    try {
      // Make a GET request to the API
      final response = await http.get(Uri.parse(apiUrl));

      // Decode the JSON response
      var data = jsonDecode(response.body);

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        return Users.fromJson(data); // Parse and return the Users object
      } else {
        // If status code is not 200, throw an exception with the status code
        throw Exception(
            'Failed to load items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors that may occur during the HTTP request or JSON parsing
      if (e is http.ClientException) {
        // Handle network-related errors
        throw Exception(
            'Network error: Please check your internet connection.');
      } else {
        throw Exception('Error fetching products: $e');
      }
    }
  }
}
