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

    List result = await db.rawQuery('''
      SELECT ${ClassMain.table}.${ClassMain.colId},
             ${ClassMain.table}.${ClassMain.colName},
             ${ClassMain.table}.${ClassMain.colPeriod},
             ${ClassMain.table}.${ClassMain.colRegime},
             GROUP_CONCAT(${Discipline.table}.${Discipline.colName}, ', ') ${ClassMain.colDiciplines} 
        FROM ${ClassMain.table}
       INNER JOIN ${ClassDiscipline.table} ON (${ClassDiscipline.table}.${ClassDiscipline.colIdClass} = ${ClassMain.table}.${ClassMain.colId})
       INNER JOIN ${Discipline.table} ON (${Discipline.table}.${Discipline.colId} = ${ClassDiscipline.table}.${ClassDiscipline.colIdDiscipline})
       GROUP BY ${ClassMain.table}.${ClassMain.colName},
                ${ClassMain.table}.${ClassMain.colPeriod},
                ${ClassMain.table}.${ClassMain.colRegime}
    ''');
    //List result = await db.query(ClassMain.table);

    return result.map((e) => ClassMain.fromMap(e)).toList();
  }

  Future<ClassMain> getById({required int classId}) async {
    Database db = await LocalDatabase().db;

    List result = await db.rawQuery('''
      SELECT ${ClassMain.table}.${ClassMain.colId},
             ${ClassMain.table}.${ClassMain.colName},
             ${ClassMain.table}.${ClassMain.colPeriod},
             ${ClassMain.table}.${ClassMain.colRegime},
             NULL ${ClassMain.colDiciplines} 
        FROM ${ClassMain.table}
       WHERE ${ClassMain.table}.${ClassMain.colId} = ${classId}
    ''');
    //List result = await db.query(ClassMain.table);

    return result.map((e) => ClassMain.fromMap(e)).first;
  }

  String getRegime(int regime) {
    switch (regime) {
      case 1:
        return 'Anual';
      case 2:
        return 'Semestral';
      default:
        return '';
    }
  }

  String getPeriod(int period) {
    switch (period) {
      case 1:
        return 'Matutino';
      case 2:
        return 'Vespertino';
      case 3:
        return 'Noturno';
      default:
        return '';
    }
  }

  Future<String> getAllJson() async {
    Database db = await LocalDatabase().db;

    List result = await db.query(ClassMain.table);

    result.map((e) => ClassMain.fromMap(e)).toList();

    return jsonEncode(result);
  }
}