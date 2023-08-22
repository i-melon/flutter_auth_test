// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter_auth_test/src/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_test/core/color_data.dart';
import 'package:flutter_auth_test/core/title_text.dart';
import 'package:flutter_auth_test/core/widgets/main_button.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  static var page;

  HomePage({super.key});
  TextEditingController loginInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  String nick = '';
  String email = '';
  String message = '';

//http post request
  Future<bool> _logIn() async {
    final String url = 'http://45.10.110.181:8080/api/v1/auth/login';

    final Map<String, dynamic> data = {
      'email': loginInput.text,
      "password": passwordInput.text,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> answer = jsonDecode(response.body);
      print(answer);
      String accessToken = answer['tokens']['accessToken'];
      String refreshToken = answer['tokens']['refreshToken'];
      int userId = answer['user']['id'];
      email = answer['user']['email'];
      nick = answer['user']['nickname'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);
      await prefs.setInt('User ID', userId);

      return true;
    } else {
      Map<String, dynamic> answer = jsonDecode(response.body);
      print(answer);
      message = answer['message'];
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        navigationBar: const CupertinoNavigationBar(
          middle: TitleText(title: 'Авторизация'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 61,
                  child: CupertinoTextField(
                    placeholder: 'Логин или почта',
                    controller: loginInput,
                  )),
              SizedBox(
                  height: 61,
                  child: CupertinoTextField(
                    obscureText: true,
                    placeholder: 'Пароль',
                    controller: passwordInput,
                  )),
              SizedBox(height: 32),
              Container(
                  width: double.infinity,
                  height: 64,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: CupertinoButton(
                      borderRadius: BorderRadius.circular(6),
                      onPressed: () async {
                        final result = await _logIn();
                        if (result) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                      name: nick,
                                      email: email,
                                    )),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(message),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('ok'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      color: mainColor,
                      child: Text(
                        'Войти',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ))),
              const SizedBox(
                height: 20,
              ),
              const MainButton(
                title: 'Зарегистрироваться',
              )
            ],
          ),
        ));
  }
}
