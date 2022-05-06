import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';

class LocalDatabase {
  static const String _nameDb = 'unipar_cns.db';

  static final LocalDatabase _instance = LocalDatabase.internal();
  factory LocalDatabase() => _instance;
  LocalDatabase.internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async{
    final path = await getDatabasesPath();
    final pathDb = join(path, _nameDb);

    return await openDatabase(
        pathDb,
        version: 1,
        onCreate: (Database db, int version) async{
          await db.execute(TeacherHelper.sqlCreate);
        }
    );
  }

  void closeDb() async{
    Database myDb = await db;
    myDb.close();
  }
}