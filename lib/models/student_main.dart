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
  static const colFreq      = 'frequence';

  int?       id;
  int        ra;
  String     cpf;
  String     name;
  DateTime   DtNasc;
  DateTime   DtMatric;
  int        classe;
  String?    className;
  double?    frequence;

  StudentMain({this.id, required this.ra, required this.name, required this.cpf, required this.DtNasc, required this.DtMatric, required this.classe, this.className, this.frequence});

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
        frequence: double.parse(map[colFreq].toString()),
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