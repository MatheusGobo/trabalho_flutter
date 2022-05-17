class ClassMain {
  static const table        = 'classMain';
  static const colId        = 'id';
  static const colName      = 'name';
  static const colRegime    = 'regime';
  static const colPeriod    = 'periode';

  int?     id;
  String   name;
  int      regime;
  int      period;

  ClassMain({this.id, required this.name, required this.regime, required this.period});

  factory ClassMain.fromMap(Map map) {
    return ClassMain(
        id:     int.parse(map[colId].toString()),
        name:   map[colName],
        regime: int.parse(map[colRegime].toString()),
        period: int.parse(map[colPeriod].toString())
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colId        : id,
      colName      : name,
      colRegime    : regime,
      colPeriod    : period
    };
  }

}