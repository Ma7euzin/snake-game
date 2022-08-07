import 'package:flutter/material.dart';

class NotFoodPixel3 extends StatefulWidget {
  const NotFoodPixel3({ Key? key }) : super(key: key);

  @override
  State<NotFoodPixel3> createState() => _NotFoodPixel3State();
}

class _NotFoodPixel3State extends State<NotFoodPixel3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(4)
        ), 
      ),
    );
  }
}