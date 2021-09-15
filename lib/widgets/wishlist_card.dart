import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_dicoding/models/restaurant_model.dart';
import 'package:submission_2_restaurant_dicoding/pages/restaurant_detail_page.dart';
import 'package:submission_2_restaurant_dicoding/providers/wishlist_provider.dart';
import 'package:submission_2_restaurant_dicoding/theme.dart';

class WishlistCard extends StatelessWidget {
  final Restaurant restaurant;
  WishlistCard(this.restaurant);

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 14,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(restaurant),
                ),
              );
            },
            child: Hero(
              tag: restaurant.picturePath!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  restaurant.picturePath!,
                  width: 60,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name!,
                  style: primaryTextStyle.copyWith(fontWeight: semiBold),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishlistProvider.setRestaurant(restaurant);
            },
            child: Image.asset(
              'assets/button_wishlist_blue.png',
              width: 34,
            ),
          ),
        ],
      ),
    );
  }
}
