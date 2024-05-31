import 'package:flutter/material.dart';

class Heading1 extends StatelessWidget {
  final String text;
  final Color color;
  Heading1(this.text,{this.color=Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: color),);
  }
}