import 'package:flutter/material.dart';

class NotFoodPixel1 extends StatefulWidget {
  const NotFoodPixel1({ Key? key }) : super(key: key);

  @override
  State<NotFoodPixel1> createState() => _NotFoodPixel1State();
}

class _NotFoodPixel1State extends State<NotFoodPixel1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4)
        ), 
      ),
    );
  }
}