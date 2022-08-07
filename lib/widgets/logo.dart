import 'package:flutter/material.dart';

import '../theme.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Image.asset('images/logo.png', width: 1000, height: 135),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: RichText(
            text: TextSpan(
              text: 'Snake  ',
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30),
              children: const [
                TextSpan(
                  text: 'Game',
                  style: TextStyle(color: cobrinhaTheme.color),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
