class Grade{
  static const table = 'grade';
  static const colId =  'id';
  static const colStudent = 'student';
  static const colClass = 'class';
  static const colGrade = 'grade';

  int?     id;
  int      student;
  int      classe;
  double   grade;

  Grade({this.id, required this.student, required this.classe, required this.grade});

  factory Grade.fromMap(Map map){
    return Grade(
      id:       int.tryParse(map[colId].toString()),
      student:  int.parse(map[colStudent].toString()),
      classe:   int.parse(map[colClass].toString()),
      grade:    double.parse(map[colGrade].toString())
    );
  }

  Map<String, dynamic> toMap(){
    return{
      colId       : id,
      colStudent  : student,
      colClass    : classe,
      colGrade    : grade
    };
  }



}