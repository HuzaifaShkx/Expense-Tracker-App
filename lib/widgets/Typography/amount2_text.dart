import 'package:flutter/material.dart';

class Amount2 extends StatelessWidget {
  final String text;
  final Color color;
  Amount2(this.text,{this.color=Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: color),);
  }
}