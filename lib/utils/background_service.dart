import 'dart:ui';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:submission_2_restaurant_dicoding/services/restaurant_service.dart';

import 'package:flutter_test/flutter_test.dart';
import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    http.Client? client;
    String query = '';
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    try {
      var result = await RestaurantService.getRestaurants(query, client!);
      await _notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, result[0]);

      _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
      _uiSendPort?.send(null);
    } catch (e) {
      print('Error --> $e');
    }
  }
}
