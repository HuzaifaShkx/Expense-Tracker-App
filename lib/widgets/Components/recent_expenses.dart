import 'package:expense_tracker_app/colors/primary_color.dart';
import 'package:expense_tracker_app/colors/secondary_colors.dart';
import 'package:expense_tracker_app/widgets/Typography/amount2_text.dart';
import 'package:expense_tracker_app/widgets/Typography/heading1_text.dart';
import 'package:flutter/material.dart';

class RecentExpenses extends StatelessWidget {
  String title,category, amount;
  

 RecentExpenses({required this.title,required this.category,required this.amount,super.key});
  // "Education Expense",
    // "Grocery",
    // "Utility Bills",
    // "Clothing",
    // "Restaurant"
  @override
  Widget build(BuildContext context) {
   
    return  Card(
                shape: Border.all(color: pastel_blue_gray,),
                color: Colors.white,
                child: ListTile(
                  
                  tileColor: Colors.white,
                  title: Heading1(title),
                leading: category=="Education Expense"?Icon(Icons.school_outlined):category=="Grocery"?Icon(Icons.local_grocery_store_outlined):category=="Utility Bills"?Icon(Icons.receipt_long):category=="Clothing"?Icon(Icons.shopping_bag_outlined):category=="Restaurant"?Icon(Icons.restaurant_outlined):category=="Others"?Icon(Icons.pie_chart_outline):Icon(Icons.add_circle_sharp),
                trailing: Amount2(amount+"/-",color:Colors.red,),
                )) ;
  }
}