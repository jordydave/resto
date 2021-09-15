import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:submission_2_restaurant_dicoding/models/restaurant_model.dart';

class RestaurantService {
  static Future<List<Restaurant>> getRestaurants(
    String query,
    http.Client client,
  ) async {
    var headers = {'Content-Type': 'application/json'};

    final response = await client.get(
        Uri.parse('http://app.foodmarket.my.id/api/restaurant'),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];

      return data.map((json) => Restaurant.fromJson(json)).where((restaurant) {
        final titleLower = restaurant.name!.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception('Gagal Get Restaurants!');
    }
  }
}
