import 'package:sqflite/sqflite.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';

class FrequenceHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Frequence.table} (
      ${Frequence.colId}       INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Frequence.colStudent}  INTEGER,
      ${Frequence.colClass}    INTEGER,
      ${Frequence.colPercent}  REAL,
      FOREIGN KEY(${Frequence.colClass}) REFERENCES ${ClassMain.table}(${ClassMain.colId}),
      FOREIGN KEY(${Frequence.colStudent}) REFERENCES ${StudentMain.table}(${StudentMain.colId})
    )
  ''';

  Future<Frequence> insert(Frequence frequence) async {
    Database db = await LocalDatabase().db;

    await db.insert(Frequence.table, frequence.toMap());
    return frequence;
  }

  Future<int> update(Frequence frequence) async {
    Database db = await LocalDatabase().db;

    return db.update(
      Frequence.table,
      frequence.toMap(),
      where: '${Frequence.colId} = ? ',
      whereArgs: [frequence.id],
    );
  }

  Future<int> delete(Frequence frequence) async {
    Database db = await LocalDatabase().db;

    return db.delete(
      Frequence.table,
      where: '${Frequence.colId} = ? ',
      whereArgs: [frequence.id],
    );
  }

  Future<Frequence> getByStudent({required int studentId}) async {
    Database db = await LocalDatabase().db;

    List dados = await db.query(
      Frequence.table,
      where: '${Frequence.colStudent} = ?',
      whereArgs: [studentId],
    );

    return dados.map((e) => Frequence.fromMap(e)).first;
  }
}
