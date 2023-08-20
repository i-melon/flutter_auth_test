import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_test/core/color_data.dart';
import 'package:flutter_auth_test/core/title_text.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  static var page;

  const ProfilePage({super.key});
  static const String name = 'Марипбек Чингиз';
  static const String email = 'maripbekoff@gmail.com';

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(
            icon: Container(
                height: 17,
                width: 17,
                child: Image.asset('lib/assets/list.png')),
            label: 'Лента',
          ),
          BottomNavigationBarItem(
            icon: Container(
                height: 17,
                width: 17,
                child: Image.asset('lib/assets/map.png')),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Container(
                height: 17,
                width: 17,
                child: Image.asset('lib/assets/heart.png')),
            label: 'Избранные',
          ),
          BottomNavigationBarItem(
            icon: Container(
                height: 17,
                width: 17,
                child: Image.asset(
                  'lib/assets/persone.png',
                  color: mainColor,
                )),
            label: 'Профиль',
          ),
        ]),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return CupertinoPageScaffold(
                  backgroundColor: backgroundColor,
                  navigationBar: CupertinoNavigationBar(
                      middle: TitleText(title: 'Профиль')),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 120),
                          Container(
                            height: 69,
                            width: 69,
                            child: Image.asset('lib/assets/persone.png'),
                          ),
                          SizedBox(height: 15),
                          Text(
                            name,
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            email,
                            style: TextStyle(
                                color: Color.fromARGB(255, 146, 146, 146),
                                decoration: TextDecoration.none,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          Container(
                            width: double.infinity,
                            height: 55,
                            color: Colors.white,
                            child: Row(
                              children: [
                                CupertinoButton(
                                    borderRadius: BorderRadius.circular(0),
                                    onPressed: () => context.go('/'),
                                    child: Text(
                                      'Выйти',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 236, 58, 77),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ]),
                  ));
            },
          );
        });
  }
}
