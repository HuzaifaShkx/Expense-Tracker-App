

import 'package:expense_tracker_app/Sqflite%20lecture/icomeDB.dart';
import 'package:expense_tracker_app/colors/primary_color.dart';
import 'package:expense_tracker_app/colors/secondary_colors.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  TextEditingController contAmount = TextEditingController();
  TextEditingController contDate = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Add Income"),),
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width * 0.9,
                  child: TextFormField(
                    controller: contAmount,
                    decoration: InputDecoration(
                        label: Text("Amount"),
                        hintText: "Amount",
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
             
           
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width * 0.9,
                  child: TextFormField(
                    controller: contDate,
                    decoration: InputDecoration(
                      label: Text("Date"),
                      hintText: "Date",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null &&
                              pickedDate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickedDate;
                              contDate.text =
                                  '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
                            });
                          }
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
             
              SizedBox(
                height: height * .04,
              ),
              ElevatedButton(
                onPressed: () async{
                  int r=await DBHelperIncome.instance.insertIncome(int.parse(contAmount.text), contDate.text.toString());
                  if(r>0){
                  final snackBar=SnackBar(content: Text("Income Inserted"),backgroundColor: muted_shade_purple_blue,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else{
                  final snackBar=SnackBar(content: Text("Income Not Inserted"),backgroundColor: muted_shade_purple_blue,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                },
                child: Text(
                  "Add Income",
                  style: TextStyle(fontSize: 15, color: snow_white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: muted_shade_purple_blue),
              ),
            ]),
      ),
    );
  }
}