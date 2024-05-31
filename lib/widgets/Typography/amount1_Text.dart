import 'package:flutter/material.dart';

class Amount1 extends StatelessWidget {
  final String text;
  final Color color;
  Amount1(this.text,{this.color=Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color),);
  }
}