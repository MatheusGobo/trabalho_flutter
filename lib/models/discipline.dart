class Discipline {
  static const table           = 'discipline';
  static const colId           = 'id';
  static const colName         = 'name';
  static const colTeacher      = 'teacher';

  int?      id;
  String   name;
  int      teacher;

  Discipline({this.id, required this.name, required this.teacher});

  factory Discipline.fromMap(Map map) {
    return Discipline(
        id:       int.tryParse(map[colId].toString()),
        name:     map[colName],
        teacher:  int.parse(map[colTeacher].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colId        : id,
      colName      : name,
      colTeacher   : teacher
    };
  }
}