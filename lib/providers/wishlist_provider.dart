import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_dicoding/models/restaurant_model.dart';

class WishlistProvider with ChangeNotifier {
  List<Restaurant> _wishlist = [];

  List<Restaurant> get wishlist => _wishlist;

  set wishlist(List<Restaurant> wishlist) {
    _wishlist = wishlist;
    notifyListeners();
  }

  setRestaurant(Restaurant restaurant) {
    if (!isWishlist(restaurant)) {
      _wishlist.add(restaurant);
    } else {
      _wishlist.removeWhere((element) => element.id == restaurant.id);
    }

    notifyListeners();
  }

  isWishlist(Restaurant restaurant) {
    if (_wishlist.indexWhere((element) => element.id == restaurant.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
