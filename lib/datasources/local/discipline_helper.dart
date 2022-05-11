import 'package:sqflite/sqflite.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';

class DisciplineHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Discipline.table} (
      ${Discipline.colId}       INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Discipline.colName}     STRING PRIMARY KEY,
      ${Discipline.colTeacher}  INTEGER,
      FOREIGN KEY(${Discipline.colTeacher}) REFERENCES ${Teacher.table}(${Teacher.colRa})
    )
  ''';

  Future<Discipline> insert(Discipline discipline) async {
    Database db = await LocalDatabase().db;

    await db.insert(Discipline.table, discipline.toMap());
    return discipline;
  }

  Future<int> update(Discipline discipline) async {
    Database db = await LocalDatabase().db;

    return db.update(Discipline.table, discipline.toMap(),
        where: '${Discipline.colId} = ? ',
        whereArgs: [discipline.id]
    );
  }

  Future<int> delete(Discipline discipline) async {
    Database db = await LocalDatabase().db;

    return db.delete(Discipline.table,
        where: '${Discipline.colId} = ? ',
        whereArgs: [discipline.id]
    );
  }

  Future<List<Discipline>> getAll() async {
    Database db = await LocalDatabase().db;

    //List dados = await db.rawQuery('SELECT * FROM $editoraTabela');
    List dados = await db.query(Discipline.table);
    return dados.map((e) => Discipline.fromMap(e)).toList();

  }
}