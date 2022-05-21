import 'package:sqflite/sqflite.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';

class GradeHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Grade.table} (
      ${Grade.colId}        INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Grade.colStudent}   INTEGER,
      ${Grade.colClass}     INTEGER,
      ${Grade.colGrade1}    REAL,
      ${Grade.colGrade2}    REAL,
      ${Grade.colGrade3}    REAL,
      ${Grade.colGrade4}    REAL,
      FOREIGN KEY(${Grade.colClass}) REFERENCES ${ClassMain.table}(${ClassMain.colId}),
      FOREIGN KEY(${Grade.colStudent}) REFERENCES ${StudentMain.table}(${StudentMain.colId})
    )
  ''';

  Future<Grade> insert(Grade grade) async {
    Database db = await LocalDatabase().db;

    await db.insert(Grade.table, grade.toMap());
    return grade;
  }

  Future<int> update(Grade grade) async {
    Database db = await LocalDatabase().db;

    return db.update(
      Grade.table,
      grade.toMap(),
      where: '${Grade.colId} = ? ',
      whereArgs: [grade.id],
    );
  }

  Future<int> delete(Grade grade) async {
    Database db = await LocalDatabase().db;

    return db.delete(
      Grade.table,
      where: '${Grade.colId} = ? ',
      whereArgs: [grade.id],
    );
  }

  Future<Grade> getByStudent({required int studentId}) async {
    Database db = await LocalDatabase().db;

    List dados = await db.query(
      Grade.table,
      where: '${Grade.colStudent} = ?',
      whereArgs: [studentId],
    );

    return dados.map((e) => Grade.fromMap(e)).first;
  }
}
