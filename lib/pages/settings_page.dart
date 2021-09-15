import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_dicoding/providers/scheduling_provider.dart';
import 'package:submission_2_restaurant_dicoding/widgets/custom_dialog.dart';
import 'package:submission_2_restaurant_dicoding/widgets/platform_widget.dart';

import '../theme.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: Text('Scheduling Restaurant'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  activeTrackColor: primaryColor,
                  activeColor: primaryColor,
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduledRestaurant(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
