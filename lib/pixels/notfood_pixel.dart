import 'package:flutter/material.dart';

class NotFoodPixel extends StatefulWidget {
  const NotFoodPixel({ Key? key }) : super(key: key);

  @override
  State<NotFoodPixel> createState() => _NotFoodPixelState();
}

class _NotFoodPixelState extends State<NotFoodPixel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(4)
        ), 
      ),
    );
  }
}