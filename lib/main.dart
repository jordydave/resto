import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_dicoding/navigation.dart';
import 'package:submission_2_restaurant_dicoding/pages/main_page.dart';
import 'package:submission_2_restaurant_dicoding/pages/splash_page.dart';
import 'package:submission_2_restaurant_dicoding/providers/page_provider.dart';
import 'package:submission_2_restaurant_dicoding/providers/restaurant_provider.dart';
import 'package:submission_2_restaurant_dicoding/providers/scheduling_provider.dart';
import 'package:submission_2_restaurant_dicoding/providers/user_provider.dart';
import 'package:submission_2_restaurant_dicoding/providers/wishlist_provider.dart';
import 'package:submission_2_restaurant_dicoding/services/restaurant_service.dart';
import 'package:submission_2_restaurant_dicoding/utils/background_service.dart';
import 'package:submission_2_restaurant_dicoding/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(
            restaurantService: RestaurantService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => SplashPage(),
            '/home': (context) => MainPage(),
          },
        ),
      ),
    );
  }
}
