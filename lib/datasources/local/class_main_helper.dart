import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';

class ClassMainHelper {
  static const sqlCreate = '''
    CREATE TABLE ${ClassMain.table} (
      ${ClassMain.colId}       INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ClassMain.colName}     STRING,
      ${ClassMain.colRegime}   INTEGER,
      ${ClassMain.colPeriod}   INTEGER
    )  
  ''';

  Future<int> insert(ClassMain classMain) async {
    Database db = await LocalDatabase().db;

    return db.insert(ClassMain.table, classMain.toMap());
    //return classMain;
  }


  Future<ClassMain> update(ClassMain classMain) async {
    Database db = await LocalDatabase().db;

    await db.update(ClassMain.table, classMain.toMap(),
        where: '${ClassMain.colId} = ? ',
        whereArgs: [classMain.id]
    );

    return classMain;
  }

  Future<int> delete(ClassMain classMain) async {
    Database db = await LocalDatabase().db;

    return db.delete(ClassMain.table,
        where: '${ClassMain.colId} = ? ',
        whereArgs: [classMain.id]
    );
  }

  Future<List<ClassMain>> getAll() async {
    Database db = await LocalDatabase().db;

    //List dados = await db.rawQuery('SELECT * FROM $editoraTabela');
    List result = await db.query(ClassMain.table);

    return result.map((e) => ClassMain.fromMap(e)).toList();
  }

  Future<String> getAllJson() async {
    Database db = await LocalDatabase().db;

    List result = await db.query(ClassMain.table);

    result.map((e) => ClassMain.fromMap(e)).toList();

    return jsonEncode(result);
  }
}