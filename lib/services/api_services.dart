import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api";


  static Future<List<dynamic>> fetchCategories() async {
    final response =
        await http.get(Uri.parse("$baseUrl/food-categories"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  static Future<List<dynamic>> fetchFoodItems() async {
    final response =
        await http.get(Uri.parse("$baseUrl/food-items"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load food items");
    }
  }
}
