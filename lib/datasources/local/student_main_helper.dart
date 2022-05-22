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
        where: '${StudentMain.colId} = ? ',
        whereArgs: [studentMain.id]
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
             ${ClassMain.table}.${ClassMain.colName} AS ${StudentMain.colClassName},
             ${Frequence.table}.${Frequence.colPercent} AS ${StudentMain.colFreq},
             ((${Grade.table}.${Grade.colGrade1} +
               ${Grade.table}.${Grade.colGrade2} +
               COALESCE(${Grade.table}.${Grade.colGrade3}, 0) +
               COALESCE(${Grade.table}.${Grade.colGrade4}, 0)) / CASE ${ClassMain.table}.${ClassMain.colRegime} WHEN 1
                                                                 THEN 4
                                                                 ELSE 2 END) AS ${StudentMain.colAverage}
        FROM ${StudentMain.table}
       INNER JOIN ${ClassMain.table} ON (${ClassMain.table}.${ClassMain.colId} = ${StudentMain.table}.${StudentMain.colClass})
        LEFT JOIN ${Frequence.table} ON (${Frequence.table}.${Frequence.colStudent} = ${StudentMain.table}.${StudentMain.colId})
        LEFT JOIN ${Grade.table} ON (${Grade.table}.${Grade.colStudent} =  ${StudentMain.table}.${StudentMain.colId})
    ''');

    return dados.map((e) => StudentMain.fromMap(e)).toList();

  }

  Future<String> getByClassJson({required int classId}) async {
    Database db = await LocalDatabase().db;

    List dados = await db.rawQuery("""
      SELECT ${StudentMain.table}.${StudentMain.colId},
             ${StudentMain.table}.${StudentMain.colRa},
             ${StudentMain.table}.${StudentMain.colCpf},
             ${StudentMain.table}.${StudentMain.colName},
             ${StudentMain.table}.${StudentMain.colDtNasc},
             ${StudentMain.table}.${StudentMain.colDtMatric},
             ${StudentMain.table}.${StudentMain.colClass},
             ${ClassMain.table}.${ClassMain.colName} AS ${StudentMain.colClassName},
             0 AS ${StudentMain.colFreq}
        FROM ${StudentMain.table} 
       INNER JOIN ${ClassMain.table} on (${ClassMain.table}.${ClassMain.colId} = ${StudentMain.table}.${StudentMain.colClass})
       WHERE ${StudentMain.table}.${StudentMain.colClass} = ${classId}
    """);

    dados.map((e) => StudentMain.fromMap(e)).toList();

    return jsonEncode(dados);

  }

  Future<String> getAllJson() async {
    Database db = await LocalDatabase().db;

    List result = await db.query(StudentMain.table);

    result.map((e) => StudentMain.fromMap(e)).toList();

    return jsonEncode(result);
  }
}