import 'package:expense_tracker_app/colors/primary_color.dart';
import 'package:expense_tracker_app/colors/secondary_colors.dart';
import 'package:expense_tracker_app/widgets/Typography/amount2_text.dart';
import 'package:expense_tracker_app/widgets/Typography/heading1_text.dart';
import 'package:expense_tracker_app/widgets/Typography/heading2_text.dart';
import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  String title, amount;
  String percent;

 Expenses({required this.title,required this.amount,required this.percent,super.key});

  @override
  Widget build(BuildContext context) {
    return  ListTile(title: Heading1(title),
    leading: Container(
      alignment: Alignment.center,
      width: 40,
      height: 25,
      child: Heading2(percent+"%",color: snow_white,),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
    color: muted_shade_purple_blue,
    ),
    ),
    trailing: Amount2(amount+"/-",color: Colors.red,),
    
    ) ;
  }
}