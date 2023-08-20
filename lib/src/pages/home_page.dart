// ignore_for_file: must_be_immutable
import 'dart:convert';
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
  String accessToken = '';

//http post request
  void _logIn() async {
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
      accessToken = answer['tokens']['accessToken'];
      String refreshToken = answer['tokens']['refreshToken'];
      int userId = answer['user']['id'];
      String userEmail = answer['user']['email'];
      String userNickname = answer['user']['nickname'];

      print('Access Token: $accessToken');
      print('Refresh Token: $refreshToken');
      print('User ID: $userId');
      print('User Email: $userEmail');
      print('User Nickname: $userNickname');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);
      await prefs.setInt('User ID', userId);
      await prefs.setString('email', userEmail);
      await prefs.setString('nick', userNickname);
    } else {
      Map<String, dynamic> answer = jsonDecode(response.body);
      String message = answer['message'];
      print('POST request failed');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
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
                      onPressed: () {
                        _logIn();
                        context.go('/profile');
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
