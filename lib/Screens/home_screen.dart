import 'dart:ffi';
import 'package:expense_tracker_app/Screens/expense_detail_screen.dart';
import 'package:expense_tracker_app/Sqflite lecture/icomeDB.dart';
import 'package:expense_tracker_app/Screens/add_expense.dart';
import 'package:expense_tracker_app/Screens/add_income.dart';
import 'package:expense_tracker_app/Sqflite%20lecture/dbhelper.dart';
import 'package:expense_tracker_app/colors/primary_color.dart';
import 'package:expense_tracker_app/colors/secondary_colors.dart';
import 'package:expense_tracker_app/widgets/Components/expenses.dart';
import 'package:expense_tracker_app/widgets/Components/recent.dart';
import 'package:expense_tracker_app/widgets/Components/recent_expenses.dart';
import 'package:expense_tracker_app/widgets/Typography/amount1_Text.dart';
import 'package:expense_tracker_app/widgets/Typography/heading1_text.dart';
import 'package:expense_tracker_app/widgets/Typography/heading2_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sumIncome = 0;
  int sumExpense = 0;
  _getSumIncomeExpense() async {
    sumExpense = await DBHelper.instance.getExpenseSum();
    sumIncome = await DBHelperIncome.instance.sumIncome();
    setState(() {
      
    });
  }

  List<Map<String, dynamic>> data = [];
  _getData() async {
    data = await DBHelper.instance.getExpense();
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSumIncomeExpense();
    _getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Row(
            //   children: [
            //     CircleAvatar(
            //       backgroundImage: AssetImage('assets/images/profilepic.jpeg'),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           "Hello",
            //           style: TextStyle(fontWeight: FontWeight.w500),
            //         ),
            //         SizedBox(
            //           height: 3,
            //         ),
            //         Text(
            //           "User1",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //       ],
            //     ),
            //     Expanded(child: Container()),
            //     Icon(Icons.notifications_active_outlined),
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Center(
              child: Container(
                height: height * .16,
                width: width * .95,
                child: Card(
                  color: muted_shade_purple_blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Heading2("TOTAL BALALANCE", color: Colors.white),
                          Amount1(
                            "Rs."+(sumIncome-sumExpense).toString(),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 28,),
                  Expanded(
                    child: Container(
                      width: width*.11,
                      height: height*.11,
                      child: sumExpense==0&&sumIncome==0?Heading1(
                        "No Data to show",color: snow_white,
                      ):
                      100-((sumExpense/sumIncome)*100)==0?
                      PieChart(
                        PieChartData(
                          sections:[
                         PieChartSectionData(
                             value: (sumExpense/sumIncome)*100,
                            color:snow_white,
                            title: sumIncome == 0 ? "0%" : ((sumExpense / sumIncome) * 100).round().toString()+"%",
                            radius: 50,
                            titlePositionPercentageOffset: 1.3
                          ),
                          ]
                        ),
                      ):
                       PieChart(
                        
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: (sumExpense/sumIncome)*100,
                            color:snow_white,
                            title: sumIncome == 0 ? "0%" : ((sumExpense / sumIncome) * 100).round().toString()+"%",
                            radius: 50,
                            titlePositionPercentageOffset: 1.1
                            
                          ),
                          PieChartSectionData(
                            value: 100-((sumExpense/sumIncome)*100)==0?100:100-((sumExpense/sumIncome)*100),
                            color: pastel_blue_gray,
                            title: 'Savings',
                            radius: 45,
                            titlePositionPercentageOffset: 1.1
                          ),
                         
                        ],
                        
                      ),
                      swapAnimationCurve: Curves.bounceOut,
                      
                                      ),
                    ),
                  ),

                  ]),
                ),
              ),
            ),
            SizedBox(
              height: height * .025,
            ),
            Row(
              children: [
                Container(
                  width: width * .477,
                  height: height * 0.13,
                  child: Card(
                    color: pastel_blue_gray,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0, left:7.0),
                          child: Column(
                            children: [
                              Heading2("Income", color: dark_slate_purple),
                              Amount1(
                                "Rs."+sumIncome.toString(),
                                color: dark_slate_purple,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * .05,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: height * .055,
                            ),
                            IconButton(
                                onPressed: () async {
                                 final result=await Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddIncomeScreen()));
                                      _getSumIncomeExpense();
                                },
                                icon: Icon(Icons.add)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width * .477,
                  height: height * 0.13,
                  child: Card(
                    color: light_beige,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0, left:7.0),
                          child: Column(
                            children: [
                              Heading2("Expense", color: dark_slate_purple),
                              Amount1(
                                "Rs."+sumExpense.toString(),
                                color: dark_slate_purple,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * .05,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: height * .055,
                            ),
                            IconButton(
                                onPressed: () async {
                                  final result1=await Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddExpense(
                                            onExpenseAdded: () {
                                              setState(() {
                                                 _getSumIncomeExpense();
                                                 _getData();
                                              });
                                            },
                                          )));
                                          _getSumIncomeExpense();
                                },
                                icon: Icon(Icons.add)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * .02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Heading1("Recent Expenses"),
                  GestureDetector(
                    child: Heading2("View All"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ExpenseDetail()));
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Recent(),
              width: width,
              height: height * .5,
            ),
            // Container(
            //   child: Flexible(
            //     child: ListView.builder(
            //       itemCount: data.length,
            //       itemBuilder: (context,index){
            //         Map<String,dynamic> row=data[index];
            //         return RecentExpenses(title: row["category"], amount: row["amount"].toString());
            //       }),
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}
