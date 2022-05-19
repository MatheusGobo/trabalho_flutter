import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';

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
        version: 5, //TODO aqui é a Versão
        onCreate: (Database db, int version) async {
          await db.execute(TeacherHelper.sqlCreate);
          await db.execute(DisciplineHelper.sqlCreate);
          await db.execute(ClassMainHelper.sqlCreate);
          await db.execute(ClassDisciplineHelper.sqlCreate);
          await db.execute(StudentMainHelper.sqlCreate);
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if (oldVersion == 4) {
            await db.execute(StudentMainHelper.sqlCreate);
          }
          //TODO Aqui se coloca demais tabelas, não pode esquecer de mudar versão do banco
        },
    );
  }

  void closeDb() async{
    Database myDb = await db;
    myDb.close();
  }
}