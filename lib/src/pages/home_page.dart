// ignore_for_file: must_be_immutable
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_test/core/color_data.dart';
import 'package:flutter_auth_test/core/title_text.dart';
import 'package:flutter_auth_test/core/widgets/main_button.dart';

class HomePage extends StatelessWidget {
  static var page;

  HomePage({super.key});
  TextEditingController loginInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

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
                      onPressed: () => context.go('/profile'),
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
