import 'package:sqflite/sqflite.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';

class TeacherHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Teacher.table} (
      ${Teacher.colRa}       INTEGER PRIMARY KEY,
      ${Teacher.colName}     TEXT
      ${Teacher.colCpf}      TEXT
      ${Teacher.colBornDate} DATETIME
    )    
  ''';

  Future<Teacher> inserir(Teacher teacher) async {
    Database db = await LocalDatabase().db;

    await db.insert(Teacher.table, teacher.toMap());
    return teacher;
  }


  Future<int> update(Teacher teacher) async {
    Database db = await LocalDatabase().db;

    return db.update(Teacher.table, teacher.toMap(),
        where: '${Teacher.colRa} = ? ',
        whereArgs: [teacher.ra]
    );
  }

  Future<int> delete(Teacher teacher) async {
    Database db = await LocalDatabase().db;

    return db.delete(Teacher.table,
        where: '${Teacher.colRa} = ? ',
        whereArgs: [teacher.ra]
    );
  }


}