import 'dart:math';

import 'package:expense_tracker_app/Sqflite%20lecture/dbhelper.dart';
import 'package:expense_tracker_app/colors/primary_color.dart';
import 'package:expense_tracker_app/widgets/Components/expenses.dart';
import 'package:expense_tracker_app/widgets/Components/recent_expenses.dart';
import 'package:expense_tracker_app/widgets/Typography/heading1_text.dart';
import 'package:expense_tracker_app/widgets/Typography/heading2_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ExpenseDetail extends StatefulWidget {
  const ExpenseDetail({super.key});

  @override
  State<ExpenseDetail> createState() => _ExpenseDetailState();
}

class _ExpenseDetailState extends State<ExpenseDetail> {
   List<Map<String, dynamic>> data = [];
   List<Map<String, dynamic>> datedata = [];
   int? sumExpense;
   DateTime datemonth=DateTime.now();
   static String? d;
   List<FlSpot> spots = [
   
    ];
  _getData() async{
   data=await DBHelper.instance.getExpense();
   sumExpense=await DBHelper.instance.getExpenseSum();
   setState(() {
     
   });
  }
  
  _getDataByDate () async {
    
  spots.clear();
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), firstDate: DateTime.utc(2000), lastDate: DateTime.now());
    try{
  if (pickedDate != null ) {
    
    d = pickedDate.month.toString();
  }
  else{
    d=datemonth.month.toString();
  }
    datedata = await DBHelper.instance.getExpenseDataByMonth(d!);
    spots.clear();
    for (var item in datedata) {
      spots.add(FlSpot(double.parse(item["date"].toString().split("/")[1]), double.parse(item["amount"].toString())));
    }
    }catch (e) {
      print(e.toString());
    }
  
  setState(() {});
}
  

  
  @override
  void initState() {
    super.initState();
    _getData();
    try {
    d=DateTime.now().month.toString();
    }catch(Exception ){
      print(Exception.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    spots.clear();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
    for (var item in datedata) {
     
       spots.add(FlSpot(double.parse(item["id"].toString()),double.parse(item["amount"].toString())));
    }
    return Scaffold(
      appBar: AppBar(title: Text("All Expenses"),),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                
                child: Container(
                  height: height*0.05,
                  width: width*.3,
                  child: Center(child: Heading1("Select Date")))),
              ElevatedButton(onPressed: _getDataByDate, child:Icon(Icons.calendar_today,color: muted_shade_purple_blue,) ),
                              
            ]
          ),
          
          Container(
  width: width * 0.9,
  height: height * 0.3,
  padding: EdgeInsets.all(8),
  child: spots.isNotEmpty
      ? LineChart(
          LineChartData(
            // Your line chart data configuration here
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: true, interval: 1000),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                colors: [muted_shade_purple_blue],
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        )
      : Center(
          child: Text(
            'No data available for selected date.',
            style: TextStyle(fontSize: 16),
          ),
        ),
),


          Flexible(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                Map<String,dynamic> row=data[index];
                double per=(row["amount"]/sumExpense)*100;
                return Expenses(title: row["name"],percent: per.round().toString(), amount: row["amount"].toString());
              }),
          )
        ],
      ),
    );
  }
}
