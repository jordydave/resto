import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_dicoding/models/restaurant_model.dart';
import 'package:submission_2_restaurant_dicoding/providers/wishlist_provider.dart';
import 'package:submission_2_restaurant_dicoding/theme.dart';
import 'package:submission_2_restaurant_dicoding/widgets/restaurant_menu.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantDetailPage(this.restaurant);

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    Widget header() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.chevron_left),
                ),
                Icon(Icons.shopping_bag, color: backgroundColor1),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Hero(
              tag: restaurant.picturePath!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  restaurant.picturePath!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 15,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name!,
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                            color: backgroundColor1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      wishlistProvider.setRestaurant(restaurant);

                      if (wishlistProvider.isWishlist(restaurant)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: secondaryColor,
                            content: Text(
                              'Has been added to the Wishlist',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: alertColor,
                            content: Text(
                              'Has been removed from the Wishlist',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    child: Image.asset(
                      wishlistProvider.isWishlist(restaurant)
                          ? 'assets/button_wishlist_blue.png'
                          : 'assets/button_wishlist.png',
                      width: 46,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      color: backgroundColor2,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    restaurant.description!,
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'List Menu',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: restaurant.foods
                          .map(
                            (food) => Padding(
                              padding: EdgeInsets.only(
                                top: 12,
                                right: 24,
                              ),
                              child: RestaurantMenu(food),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor6,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
