import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DevHelper extends StatelessWidget {
  const DevHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Данная страница находится в разработке, пожалуста пройдите в раздел "Профиль"',
          style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.none,
              color: Colors.grey,
              fontWeight: FontWeight.w500),
        ),
      ),
    ));
  }
}
