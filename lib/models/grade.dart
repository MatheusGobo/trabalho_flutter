class Grade{
  static const table      = 'grade';
  static const colId      =  'id';
  static const colStudent = 'student';
  static const colClass   = 'class';
  static const colGrade1  = 'grade1';
  static const colGrade2  = 'grade2';
  static const colGrade3  = 'grade3';
  static const colGrade4  = 'grade4';

  int?     id;
  int      student;
  int      classe;
  double   grade1;
  double   grade2;
  double?   grade3;
  double?   grade4;


  Grade({this.id, required this.student, required this.classe, required this.grade1, required this.grade2, this.grade3, this.grade4});

  factory Grade.fromMap(Map map){
    return Grade(
      id:       int.tryParse(map[colId].toString()),
      student:  int.parse(map[colStudent].toString()),
      classe:   int.parse(map[colClass].toString()),
      grade1:   double.parse(map[colGrade1].toString()),
      grade2:   double.parse(map[colGrade2].toString()),
      grade3:   map[colGrade3] != null ? double.parse(map[colGrade3].toString()) : 0,
      grade4:   map[colGrade4] != null ? double.parse(map[colGrade4].toString()) : 0,
    );
  }

  Map<String, dynamic> toMap(){
    return{
      colId       : id,
      colStudent  : student,
      colClass    : classe,
      colGrade1   : grade1,
      colGrade2   : grade2,
      colGrade3   : grade3,
      colGrade4   : grade4
    };
  }



}