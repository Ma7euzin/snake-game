import 'package:flutter/material.dart';

class NotFoodPixel4 extends StatefulWidget {
  const NotFoodPixel4({ Key? key }) : super(key: key);

  @override
  State<NotFoodPixel4> createState() => _NotFoodPixel4State();
}

class _NotFoodPixel4State extends State<NotFoodPixel4> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4)
        ), 
      ),
    );
  }
}