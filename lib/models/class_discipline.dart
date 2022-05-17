class ClassDiscipline {
  static const table           = 'classDiscipline';
  static const colId           = 'id';
  static const colIdClass      = 'id_class';
  static const colIdDiscipline = 'id_discipline';

  int?     id;
  int      idClass;
  int      idDiscipline;

  ClassDiscipline({this.id, required this.idClass, required this.idDiscipline});

  factory ClassDiscipline.fromMap(Map map) {
    return ClassDiscipline(
        id:           int.parse(map[colId].toString()),
        idClass:      int.parse(map[colIdClass].toString()),
        idDiscipline: int.parse(map[colIdDiscipline].toString()),
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