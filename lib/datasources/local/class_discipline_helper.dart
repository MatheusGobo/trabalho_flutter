import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';

class ClassDisciplineHelper {
  static const sqlCreate = '''
    CREATE TABLE ${ClassDiscipline.table} (
      ${ClassDiscipline.colId}             INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ClassDiscipline.colIdClass}        INTEGER,
      ${ClassDiscipline.colIdDiscipline}   INTEGER,
      FOREIGN KEY(${ClassDiscipline.colIdClass})      REFERENCES ${ClassMain.table}(${ClassMain.colId}),
      FOREIGN KEY(${ClassDiscipline.colIdDiscipline}) REFERENCES ${Discipline.table}(${Discipline.colId})
    )  
  ''';

  Future<ClassDiscipline> insert(ClassDiscipline classDiscipline) async {
    Database db = await LocalDatabase().db;

    await db.insert(ClassDiscipline.table, classDiscipline.toMap());
    return classDiscipline;
  }


  Future<int> update(ClassDiscipline classDiscipline) async {
    Database db = await LocalDatabase().db;

    return db.update(ClassDiscipline.table, classDiscipline.toMap(),
        where: '${ClassDiscipline.colId} = ? ',
        whereArgs: [classDiscipline.id]
    );
  }

  Future<int> delete(int idClass) async {
    Database db = await LocalDatabase().db;

    return db.delete(ClassDiscipline.table,
        where: '${ClassDiscipline.colIdClass} = ? ',
        whereArgs: [idClass]
    );
  }

  Future<List<ClassDiscipline>> getAll() async {
    Database db = await LocalDatabase().db;

    //List dados = await db.rawQuery('SELECT * FROM $editoraTabela');
    List result = await db.query(ClassDiscipline.table);

    return result.map((e) => ClassDiscipline.fromMap(e)).toList();
  }

  Future<String> getAllJson() async {
    Database db = await LocalDatabase().db;

    List result = await db.query(ClassDiscipline.table);

    result.map((e) => ClassDiscipline.fromMap(e)).toList();

    return jsonEncode(result);
  }
}