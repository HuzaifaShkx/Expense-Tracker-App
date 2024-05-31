import 'package:expense_tracker_app/Sqflite%20lecture/dbhelper.dart';
import 'package:expense_tracker_app/widgets/Components/recent_expenses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Recent extends StatefulWidget {
  const Recent({super.key});

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  List<Map<String, dynamic>> data = [];

  _getData() async{
   data=await DBHelper.instance.getTopRecent();
   setState(() {
     
   });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(itemCount: data.length,
                    itemBuilder: (context,index){
                      Map<String,dynamic> row=data[index];
                      return RecentExpenses(title: row["name"],category: row["category"], amount: row["amount"].toString());
                    }),
    );
  }
}