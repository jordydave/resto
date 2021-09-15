import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_dicoding/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_dicoding/theme.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();

    super.initState();
  }

  getInit() async {
    await Provider.of<RestaurantProvider>(context, listen: false)
        .getRestaurant();
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/image_splash.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
