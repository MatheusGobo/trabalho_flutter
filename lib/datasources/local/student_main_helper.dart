import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';

class StudentMainHelper {
  static const sqlCreate = '''
    CREATE TABLE ${StudentMain.table} (
      ${StudentMain.colId}       INTEGER PRIMARY KEY AUTOINCREMENT,
      ${StudentMain.colRa}       INTEGER,
      ${StudentMain.colCpf}      TEXT,
      ${StudentMain.colName}     TEXT,
      ${StudentMain.colDtNasc}   TEXT,
      ${StudentMain.colDtMatric} TEXT,
      ${StudentMain.colClass}    INTEGER,
      FOREIGN KEY(${StudentMain.colClass}) REFERENCES ${ClassMain.table}(${ClassMain.colId})
    )  
  ''';

  Future<StudentMain> insert(StudentMain studentMain) async {
    Database db = await LocalDatabase().db;

    await db.insert(StudentMain.table, studentMain.toMap());
    return studentMain;
  }


  Future<StudentMain> update(StudentMain studentMain) async {
    Database db = await LocalDatabase().db;

    await db.update(StudentMain.table, studentMain.toMap(),
        where: '${StudentMain.colRa} = ? ',
        whereArgs: [studentMain.ra]
    );

    return studentMain;
  }

  Future<int> delete(StudentMain studentMain) async {
    Database db = await LocalDatabase().db;

    return db.delete(StudentMain.table,
        where: '${StudentMain.colId} = ? ',
        whereArgs: [studentMain.id]
    );
  }

  Future<List<StudentMain>> getAll() async {
    Database db = await LocalDatabase().db;

    List dados = await db.rawQuery('''
      SELECT ${StudentMain.table}.${StudentMain.colId},
             ${StudentMain.table}.${StudentMain.colRa},
             ${StudentMain.table}.${StudentMain.colCpf},
             ${StudentMain.table}.${StudentMain.colName},
             ${StudentMain.table}.${StudentMain.colDtNasc},
             ${StudentMain.table}.${StudentMain.colDtMatric},
             ${StudentMain.table}.${StudentMain.colClass},
             ${ClassMain.table}.${ClassMain.colName} AS ${StudentMain.colClassName}
        FROM ${StudentMain.table}
       INNER JOIN ${ClassMain.table} on (${ClassMain.table}.${ClassMain.colId} = ${StudentMain.table}.${ClassMain.colId})
    ''');

    return dados.map((e) => StudentMain.fromMap(e)).toList();

  }

  Future<String> getAllJson() async {
    Database db = await LocalDatabase().db;

    List result = await db.query(StudentMain.table);

    result.map((e) => StudentMain.fromMap(e)).toList();

    return jsonEncode(result);
  }
}