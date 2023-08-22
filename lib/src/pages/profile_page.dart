import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_test/core/color_data.dart';
import 'package:flutter_auth_test/core/title_text.dart';
import 'package:flutter_auth_test/core/widgets/dev_helper.dart';
import 'package:flutter_auth_test/core/widgets/profile_component.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  static var page;
  final name;
  final email;
  ProfilePage({super.key, required this.email, required this.name});
  Future<Map<String, String>> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final refreshToken = prefs.getString('refresh_token') ?? '';
    final email = prefs.getString('email') ?? '';
    final nick = prefs.getString('nick') ?? '';
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'nick': nick,
      'email': email
    };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar:
            CupertinoTabBar(currentIndex: 3, activeColor: mainColor, items: [
          BottomNavigationBarItem(
            activeIcon: Container(
                height: 17,
                width: 17,
                child: Image.asset(
                  'lib/assets/list.png',
                  color: mainColor,
                )),
            icon: Container(
                height: 17,
                width: 17,
                child: Image.asset('lib/assets/list.png')),
            label: 'Лента',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
                height: 17,
                width: 17,
                child: Image.asset(
                  'lib/assets/map.png',
                  color: mainColor,
                )),
            icon: Container(
                height: 17,
                width: 17,
                child: Image.asset('lib/assets/map.png')),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
                height: 17,
                width: 17,
                child: Image.asset(
                  'lib/assets/heart.png',
                  color: mainColor,
                )),
            icon: Container(
                height: 17,
                width: 17,
                child: Image.asset('lib/assets/heart.png')),
            label: 'Избранные',
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
                height: 17,
                width: 17,
                child: Image.asset(
                  'lib/assets/persone.png',
                  color: mainColor,
                )),
            icon: Container(
                height: 17,
                width: 17,
                child: Image.asset(
                  'lib/assets/persone.png',
                )),
            label: 'Профиль',
          ),
        ]),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              if (index == 3) {
                return ProfileComponent(
                  name: name,
                  email: email,
                );
              } else {
                return DevHelper();
              }
            },
          );
        });
  }
}
