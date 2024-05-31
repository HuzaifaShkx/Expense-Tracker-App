import 'package:flutter/material.dart';

class CategoryNameText extends StatelessWidget {
  final String text;
  final Color color;
  CategoryNameText(this.text,{this.color=Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: color),);
  }
}