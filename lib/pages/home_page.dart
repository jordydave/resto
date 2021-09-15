import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_dicoding/models/restaurant_model.dart';
import 'package:submission_2_restaurant_dicoding/pages/restaurant_detail_page.dart';
import 'package:submission_2_restaurant_dicoding/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_dicoding/services/restaurant_service.dart';
import 'package:submission_2_restaurant_dicoding/theme.dart';
import 'package:submission_2_restaurant_dicoding/widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<Restaurant> restaurants = [];
  String query = '';
  Timer? debouncer;
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(seconds: 1),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final restaurants =
        await RestaurantService.getRestaurants(query, http.Client());

    setState(() {
      this.restaurants = restaurants;
    });
  }

  @override
  Widget build(BuildContext context) {
    RestaurantProvider restaurantProvider =
        Provider.of<RestaurantProvider>(context);
    Future searchRestaurant(String query) async => debounce(
          () async {
            final restaurants =
                await RestaurantService.getRestaurants(query, http.Client());
            if (!mounted) return;

            setState(() {
              this.query = query;
              this.restaurants = restaurants;
            });
          },
        );

    Widget search() {
      return SearchWidget(
        text: query,
        onChanged: searchRestaurant,
        hintText: 'Search Restaurant',
      );
    }

    Widget buildRestaurant(Restaurant restaurant) {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
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
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    restaurant.picturePath!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
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
                  SizedBox(height: 6),
                  Text(
                    restaurant.name!,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                      color: backgroundColor1,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 6),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: backgroundColor1,
                        ),
                        SizedBox(width: 6),
                        Text(
                          restaurant.address!,
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await restaurantProvider.getRestaurant();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            'List Restaurants',
          ),
          actions: [
            GestureDetector(
              key: Key('done_page_button'),
              onTap: () async {
                hasInternet = await InternetConnectionChecker().hasConnection;

                _connectionStatus = await Connectivity().checkConnectivity();

                final text = hasInternet ? 'Internet' : 'No Internet';

                if (_connectionStatus == ConnectivityResult.mobile) {
                  restaurantProvider.getRestaurant();
                } else if (_connectionStatus == ConnectivityResult.wifi) {
                  restaurantProvider.getRestaurant();
                } else {
                  showSimpleNotification(
                    Text('$text: Check your connection!'),
                  );
                }
              },
              child: Icon(Icons.refresh),
            ),
          ],
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                search(),
                Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == ResultState.HasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurants[index];

                          return buildRestaurant(restaurant);
                        },
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(
                        child: Text(
                          'Check Your Internet Connection',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (state.state == ResultState.Error) {
                      return Center(
                        child: Text(
                          'Check Your Internet Connection',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Check Your Internet Connection',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            physics: ScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
