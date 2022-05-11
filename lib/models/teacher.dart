class Teacher {
  static const table         = 'teacher';
  static const colRa        = 'ra';
  static const colName      = 'name';
  static const colCpf       = 'cpf';
  static const colBornDate = 'born_date';

  int      ra;
  String   name;
  String   cpf;
  DateTime bornDate;

  Teacher({required this.ra, required this.name, required this.cpf, required this.bornDate});

  factory Teacher.fromMap(Map map) {
    return Teacher(
        ra:       int.parse(map[colRa].toString()),
        name:     map[colName],
        cpf:      map[colCpf],
        bornDate: DateTime.parse(map[colBornDate])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colRa        : ra,
      colName      : name,
      colCpf       : cpf,
      colBornDate  : bornDate.toIso8601String()
    };
  }

}