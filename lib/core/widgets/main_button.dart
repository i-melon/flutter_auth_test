import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_test/core/color_data.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 64,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: CupertinoButton(
            borderRadius: BorderRadius.circular(6),
            onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Данная функция находится в разработке'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('Буду ждать =)'),
                      ),
                    ],
                  ),
                ),
            color: mainColor,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            )));
  }
}
