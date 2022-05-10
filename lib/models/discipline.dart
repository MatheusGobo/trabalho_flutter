class Discipline {
  static const table           = 'discipline';
  static const colName         = 'name';
  static const colTeacher      = 'teacher';

  String   name;
  int      teacher;

  Discipline({required this.name, required this.teacher});

  factory Discipline.fromMap(Map map) {
    return Discipline(
        name:     map[colName],
        teacher:  int.parse(map[colTeacher].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colTeacher   : teacher,
      colName      : name
    };
  }
}