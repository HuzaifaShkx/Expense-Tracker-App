import 'package:expense_tracker_app/widgets/Typography/amount1_Text.dart';
import 'package:expense_tracker_app/widgets/Typography/heading1_text.dart';
import 'package:expense_tracker_app/widgets/Typography/heading2_text.dart';
import 'package:flutter/material.dart';

class AboutUserScreen extends StatefulWidget {
  const AboutUserScreen({super.key});

  @override
  State<AboutUserScreen> createState() => _AboutUserScreenState();
}

class _AboutUserScreenState extends State<AboutUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Center(child: Amount1("Date"+DateTime.now().day.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().year.toString())),
            
          ],
        ),
      ),
    );
  }
}