import 'package:expense_tracker_app/Sqflite%20lecture/dbhelper.dart';
import 'package:expense_tracker_app/Sqflite%20lecture/icomeDB.dart';
import 'package:expense_tracker_app/colors/primary_color.dart';
import 'package:expense_tracker_app/colors/secondary_colors.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddExpense extends StatefulWidget {
  
  final VoidCallback onExpenseAdded;
  const AddExpense({required this.onExpenseAdded,super.key});
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController contAmount = TextEditingController();
  TextEditingController contName = TextEditingController();
  TextEditingController contDescr = TextEditingController();
  TextEditingController contDate = TextEditingController();
  List<String> categories = [
    "Education Expense",
    "Grocery",
    "Utility Bills",
    "Clothing",
    "Restaurant",
    "Others"
  ];
  DateTime? _selectedDate;
  String? _selectedCate;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
      ),
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
                    controller: contName,
                    decoration: InputDecoration(
                        label: Text("Expense Name"),
                        hintText: "Expense Name",
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Container(
                width: width * 0.9,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton(
                  hint: Text("Categories"),
                  isExpanded: true,
                  elevation: 0,
                  underline: Text(""),
                  value: _selectedCate,
                  items: categories
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    _selectedCate = value;
                    setState(() {});
                  },
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width * 0.9,
                  child: TextFormField(
                    controller: contDescr,
                    decoration: InputDecoration(
                        label: Text("Description"),
                        hintText: "Description",
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(
                height: height * .04,
              ),
              ElevatedButton(
                onPressed: ()async {
                 int r=await DBHelper.instance.insertExpense(contName.text, int.parse(contAmount.text), _selectedCate.toString(), contDescr.text, contDate.text);
                  // widget.onExpenseAdded();
                //  int month=int.parse(contDate.text.split('/')[1]);
                //  int year=int.parse(contDate.text.split('/')[2]);
                //  int n=await DBHelperIncome.instance.updateIncome(month,year, int.parse(contAmount.text));
                if(r>0){
                  final snackBar=SnackBar(content: Text("Expense Inserted"),backgroundColor: muted_shade_purple_blue,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else{
                  final snackBar=SnackBar(content: Text("Expense Not Inserted"),backgroundColor: muted_shade_purple_blue,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                
                },
                child: Text(
                  "Add Expense",
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
