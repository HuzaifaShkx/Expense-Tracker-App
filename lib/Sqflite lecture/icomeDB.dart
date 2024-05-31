

import 'package:sqflite/sqflite.dart';

class DBHelperIncome{
  DBHelperIncome._privateConstructor();
  Database? _database;
  static DBHelperIncome instance =DBHelperIncome._privateConstructor();

  Future<Database> get database async{
    if(_database == null){
      _database =await initializeDB();
    }
    return _database!;
  }

  Future<Database> initializeDB() async {
     String path=await getDatabasesPath();
     String dbpath=path+"/expensetracker.db";
     Database db=await openDatabase(dbpath);
     return db;
  }
  

  Future<int> insertIncome(int amount,String date)async{
    // String query=''' 
    //   insert into Student(name,reg,photo) values('${name}','${reg}','${ph}')
    //  ''';
    //  Database db = await database;
    //  return await db.rawInsert(query);

    Database db = await database;
    return await db.insert("Income", {"amount":amount,"date":date});
    
  }

  Future<List<Map<String,dynamic>>> getIncome() async {
    Database db = await database;
    return await db.query("Income",);
  }

  Future<int> sumIncome()async{
    Database db = await database;
    List<Map<String,dynamic>> list=await db.query("Income");
    int sum=0;
    for(int i=0;i<list.length;i++){
      String n=list[i]["amount"].toString();
      sum+=int.parse(n);
    }
    return sum;
  }

  Future<int> updateIncome(int month,int year,int am)async{
    int sum=0;
    Database db = await database;
    List<Map<String,dynamic>> list=await db.query("Income",where: "date=_/${month}/${year}");
    for(int i=0;i<list.length;i++){
      String n=list[i]["amount"].toString();
      sum+=int.parse(n);
      
    }
    sum-=am;
      String query="update Income set amount=$sum where date=_/${month}/${year}";
      return await db.rawUpdate(query);
  }
}