import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  final String text;
  final Color color;
  PageHeading(this.text,{this.color=Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color),);
  }
}