class ClassDiscipline {
  static const table           = 'classDiscipline';
  static const colId           = 'id';
  static const colIdClass      = 'idClass';
  static const colIdDiscipline = 'idDiscipline';
  static const colNameDiscipline = 'nameDiscipline';

  int?     id;
  int      idClass;
  int      idDiscipline;
  String?  nameDiscipline;

  ClassDiscipline({this.id, required this.idClass, required this.idDiscipline, this.nameDiscipline});

  factory ClassDiscipline.fromMap(Map map) {
    return ClassDiscipline(
        id:             int.parse(map[colId].toString()),
        idClass:        int.parse(map[colIdClass].toString()),
        idDiscipline:   int.parse(map[colIdDiscipline].toString()),
        nameDiscipline: map[colNameDiscipline],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colId           : id,
      colIdClass      : idClass,
      colIdDiscipline : idDiscipline,
    };
  }

}