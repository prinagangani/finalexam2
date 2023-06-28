import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class dbHelper {
  Database? database;

  Future checkDb() async {
    if (database != null) {
      return database;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "table.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE incomeexp(id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT,amount TEXT,date TEXT,paytype TEXT,status INTEGER,notes TEXT)";
        db.execute(query);
      },
    );
  }

  Future<void> insertDb(
      {required category,
        required amount,
        required date,
        required paytype,
        required status,
        required notes,
        }) async {
    database = await checkDb();
    database!.insert("incomeexp", {
      "category": category,
      "amount": amount,
      "date": date,
      "paytype": paytype,
      "status": status,
      "notes": notes,
    });
  }

  Future<List<Map>> readDb() async {
    database = await checkDb();
    String query = "SELECT*FROM incomeexp";
    List<Map> readList = await database!.rawQuery(query);
    print(readList);
    return readList;
  }


  Future<void> deleteDb({required id})
  async {
    database = await checkDb();
    database!.delete("incomeexp", where:"id=?", whereArgs: [id]);
  }

  Future<void> updateDb(
      {required id,
        required category,
        required amount,
        required date,
        required paytype,
        required status,
        required notes,
        }) async {
    database = await checkDb();
    database!.update(
        "incomeexp",
        {
          "category": category,
          "amount": amount,
          "date": date,
          "paytype": paytype,
          "status": status,
          "notes": notes,
        }, where: "id=?", whereArgs: [id]);
  }

  Future<List<Map>> incomeFilter({required status}) async {
    database = await checkDb();
    String s1 = "SELECT * FROM incomeexp WHERE status = '$status'";
    List<Map> list = await database!.rawQuery(s1);
    return list;
  }

  Future<List<Map>> totalIncome()
  async {
    database = await checkDb();
    String sql = 'SELECT SUM(amount) FROM incomeexp WHERE status=1';
    List<Map> list = await database!.rawQuery(sql);
    return list;
  }
  Future<List<Map>> totalExpanse()
  async {
    database = await checkDb();
    String sql = 'SELECT SUM(amount) FROM incomeexp WHERE status=0';
    List<Map> list = await database!.rawQuery(sql);
    return list;
  }

  // Future<List<Map>> payFiltrr({required payType})
  // async{
  //   String sql = "SELECT*FROM incomeexp WHERE paytype = ${payType}";
  //   List<Map> list = await database!.rawQuery(sql);
  //   return list;
  // }
}
