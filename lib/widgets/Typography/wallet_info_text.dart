import 'package:flutter/material.dart';

class WalletInfoText extends StatelessWidget {
  final String text;
  final Color color;
  WalletInfoText(this.text,{this.color=Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 8,fontWeight: FontWeight.w300,color: color),);
  }
}