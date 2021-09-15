import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_dicoding/pages/home_page.dart';
import 'package:submission_2_restaurant_dicoding/pages/settings_page.dart';
import 'package:submission_2_restaurant_dicoding/pages/wishlist_page.dart';
import 'package:submission_2_restaurant_dicoding/providers/page_provider.dart';
import 'package:submission_2_restaurant_dicoding/theme.dart';
import 'package:submission_2_restaurant_dicoding/utils/notification_helper.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject('/home');
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            backgroundColor: subtitleColor,
            currentIndex: pageProvider.currentIndex,
            onTap: (value) {
              print(value);
              pageProvider.currentIndex = value;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon_home.png',
                    width: 21,
                    color: pageProvider.currentIndex == 0
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon_wishlist.png',
                    width: 20,
                    color: pageProvider.currentIndex == 1
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Icon(
                    Icons.settings,
                    color: pageProvider.currentIndex == 2
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return WishlistPage();
        case 2:
          return SettingsPage();

        default:
          return HomePage();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
