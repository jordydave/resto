import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_dicoding/models/restaurant_model.dart';
import 'package:submission_2_restaurant_dicoding/services/restaurant_service.dart';

import 'package:http/http.dart' as http;

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider with ChangeNotifier {
  final RestaurantService restaurantService;

  RestaurantProvider({required this.restaurantService}) {
    getRestaurant();
  }
  http.Client? client;
  List<Restaurant> _restaurant = [];
  List<Restaurant> get restaurants => _restaurant;
  String query = '';
  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;
  List<Restaurant> get restaurant => _restaurant;

  set restaurant(List<Restaurant> restaurant) {
    _restaurant = restaurant;
    notifyListeners();
  }

  Future<dynamic> getRestaurant() async {
    try {
      _state = ResultState.Loading;
      final restaurant = await RestaurantService.getRestaurants(query, client!);
      if (restaurant.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
