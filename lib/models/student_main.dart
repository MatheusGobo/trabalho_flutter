class StudentMain {
  static const table        = 'student';
  static const colId        = 'id';
  static const colRa        = 'ra';
  static const colCpf       = 'cpf';
  static const colName      = 'name';
  static const colDtNasc    = 'dtNasc';
  static const colDtMatric  = 'dtMatric';
  static const colClass     = 'classe';
  static const colClassName = 'className';

  int?       id;
  int?       ra;
  String     cpf;
  String     name;
  DateTime   DtNasc;
  DateTime   DtMatric;
  int?       classe;
  String?    className;

  StudentMain({this.id, this.ra, required this.name, required this.cpf, required this.DtNasc, required this.DtMatric, this.classe, this.className});

  factory StudentMain.fromMap(Map map) {
    return StudentMain(
        id:        int.parse(map[colId].toString()),
        ra:        int.parse(map[colRa].toString()),
        name:      map[colName],
        cpf:       map[colCpf],
        DtNasc:    DateTime.parse(map[colDtNasc]),
        DtMatric:  DateTime.parse(map[colDtMatric]),
        classe:    int.parse(map[colClass].toString()),
        className: map[colClassName],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colId        : id,
      colRa        : ra,
      colCpf       : cpf,
      colName      : name,
      colDtNasc    : DtNasc.toIso8601String(),
      colDtMatric  : DtMatric.toIso8601String(),
      colClass     : classe
    };
  }

}