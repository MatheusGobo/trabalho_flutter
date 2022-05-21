class Frequence {
  static const table           = 'frequence';
  static const colId           = 'id';
  static const colStudent      = 'student';
  static const colClass        = 'class';
  static const colPercent      = 'percent';

  int?     id;
  int      student;
  int      classe;
  double   percent;

  Frequence({this.id, required this.student, required this.classe, required this.percent});

  factory Frequence.fromMap(Map map) {
    return Frequence(
        id:       int.tryParse(map[colId].toString()),
        student:  int.parse(map[colStudent].toString()),
        classe:   int.parse(map[colClass].toString()),
        percent : double.parse(map[colPercent].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colId         : id,
      colStudent    : student,
      colClass      : classe,
      colPercent    : percent
    };
  }
}