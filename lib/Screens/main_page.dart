import 'package:expense_tracker_app/Screens/about_user.dart';
import 'package:expense_tracker_app/Screens/add_expense.dart';
import 'package:expense_tracker_app/Screens/expense_detail_screen.dart';
import 'package:expense_tracker_app/Screens/home_screen.dart';
import 'package:expense_tracker_app/colors/primary_color.dart';
import 'package:expense_tracker_app/colors/secondary_colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    List pages = [
    HomeScreen(),
    ExpenseDetail(),
    AddExpense(
      onExpenseAdded: () {
        setState(() {
          
        });
      },
    ),
    //AboutUserScreen(),
  ];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          selectedItemColor: muted_shade_purple_blue,
          unselectedItemColor: muted_shade_purple_blue,
          unselectedLabelStyle: TextStyle(color: muted_shade_purple_blue),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: muted_shade_purple_blue,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.graphic_eq_outlined,
                  color: muted_shade_purple_blue,
                ),
                label: "Expenses"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.attach_money,
                  color: muted_shade_purple_blue,
                ),
                label: "Add Expense"),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.person_2_outlined,
            //       color: muted_shade_purple_blue,
            //     ),
            //     label: "Profile"),
          ]),
      body: pages[_selectedIndex],
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // resizeToAvoidBottomInset: false,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(right: 140),
      //   child: FloatingActionButton(
      //     backgroundColor: muted_shade_purple_blue,
      //     shape:
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      //     child: Icon(
      //       Icons.add,
      //       color: snow_white,
      //     ),
      //     onPressed: () {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => AddExpense(
      //                     onExpenseAdded: () {
      //                       setState(() {
      //                       });
      //                     },
      //                   )));
      //     },
      //   ),
      //),
    );
  }
}
