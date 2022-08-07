import 'package:flutter/material.dart';

class NotFoodPixel2 extends StatefulWidget {
  const NotFoodPixel2({ Key? key }) : super(key: key);

  @override
  State<NotFoodPixel2> createState() => _NotFoodPixel2State();
}

class _NotFoodPixel2State extends State<NotFoodPixel2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(4)
        ), 
      ),
    );
  }
}