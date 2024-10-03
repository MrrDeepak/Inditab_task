import 'package:inditab_task_flutter/models/user_modal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String apiUrl = 'https://ixifly.in/flutter/task2';

  static Future<Users> getUserData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      var data = jsonDecode(response.body);
      //print(response.body);
      if (response.statusCode == 200) {
        return Users.fromJson(data);
      } else {
        throw Exception(
            'Failed to load items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or JSON parsing errors
      //print('Error fetching products: $e');
      throw Exception('Error fetching products: $e');
    }
  }
}
