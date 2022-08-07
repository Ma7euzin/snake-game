
import 'package:flutter/material.dart';

class BlackPixel extends StatefulWidget {
  const BlackPixel({ Key? key }) : super(key: key);

  @override
  State<BlackPixel> createState() => _BlackPixelState();
}

class _BlackPixelState extends State<BlackPixel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        
        decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(0)
        ), 
      ),
    );
  }
}