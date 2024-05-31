

import 'package:sqflite/sqflite.dart';

class DBHelper{
  DBHelper._privateConstructor();
  Database? _database;
  static DBHelper instance =DBHelper._privateConstructor();

  Future<Database> get database async{
    if(_database == null){
      _database =await initializeDB();
    }
    return _database!;
  }

  Future<Database> initializeDB() async {
     String path=await getDatabasesPath();
     String dbpath=path+"/expensetracker.db";
     Database db=await openDatabase(dbpath,
                                    version: 1,
                                    onCreate:_creatDB );
     return db;
  }
  _creatDB(Database db, int version) async {
  try {
    String query1 = ''' 
      CREATE TABLE Expense(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        amount INT,
        category TEXT,
        description TEXT,
        date TEXT
      )
    ''';
    await db.execute(query1);
    String query2 = ''' 
      CREATE TABLE Income(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount INT,
        date TEXT
      )
    ''';
    await db.execute(query2);
  } catch (e) {
    print('Error creating tables: $e');
  }
}


  Future<int> insertExpense(String name,int amount,String category,String description,String date)async{
    // String query=''' 
    //   insert into Student(name,reg,photo) values('${name}','${reg}','${ph}')
    //  ''';
    //  Database db = await database;
    //  return await db.rawInsert(query);

    Database db = await database;
    return await db.insert("Expense", {"name":name, "amount":amount, "category":category,"description":description,"date":date});
    
    // String month=date.split("/")[1];
    // int expenseAmount=amount;
    // List<Map<String,dynamic>> result=await db.rawQuery("Select * from Income where date like '%${month}/%'");
    // if(result.isNotEmpty){
    //   int remaingAmount=result[0]["amount"]-expenseAmount;
    //   await db.update("Income",{"amount":remaingAmount},where:"date like '%${month}/%'");
    // }
  }

  Future<List<Map<String,dynamic>>> getExpense() async {
    Database db = await database;
    return await db.query("Expense");
  }

  Future<int> getExpenseSum()async{
    Database db = await database;
    List<Map<String,dynamic>> list=await db.query("Expense");
    int sum=0;
    for(int i=0;i<list.length;i++){
      String n=list[i]["amount"].toString();
      sum+=int.parse(n);
    }
    return sum;
  }

  Future<List<Map<String,dynamic>>> getTopRecent()async{
    Database db=await database;
    return await db.rawQuery("SELECT * FROM Expense order by id desc limit 5"); 
  } 
 


Future<List<Map<String,dynamic>>> getExpenseDataByMonth(String month)async{
    Database db = await database;
    String q='''SELECT * from expense where date like "_%${month}/%"''';
    return await db.rawQuery(q);
  }

  Future<int> updateExpense(int id, String name, String amount, String description)async{
    Database db = await database;
    return await db.update("Expense",{"id":id,"name":name,"amount":amount,"description":description});
  }
}