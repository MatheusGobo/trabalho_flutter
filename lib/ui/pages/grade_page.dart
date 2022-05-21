import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class GradePage extends StatefulWidget {
  const GradePage({Key? key}) : super(key: key);

  @override
  State<GradePage> createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  final _gradeHelper = GradeHelper();
  final _classMainHelper = ClassMainHelper();
  final _studentMainHelper = StudentMainHelper();
  final _formKey = GlobalKey<FormState>();
  final _notaController = TextEditingController();

  Grade? _gradeStudent;

  double grade = 0.0;
  bool gradeVazio = false;

  int?  _classSelect;
  bool _classVazio = false;
  List dataClass = [];

  Future getClass() async {
    List result = json.decode(await _classMainHelper.getAllJson());
    setState(() {
      dataClass = result;
    });
  }

  int? _studentSelect;
  bool _studentVazio = false;
  List dataStudent = [];

  Future getStudent() async {
    List result = json.decode(
        await _studentMainHelper.getByClassJson(classId: _classSelect!));
    setState(() {
      dataStudent = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getClass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Nota'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Turma',
                  errorText: _classVazio ? 'Informar a Turma' : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: ThemeClass.secondColor,
                    ),
                  ),
                  fillColor: Colors.white,
                ),
                child: SizedBox(
                  height: 25,
                  child: DropdownButton(
                    enableFeedback: true,
                    borderRadius: BorderRadius.circular(18),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    focusColor: ThemeClass.primaryColor,
                    dropdownColor: ThemeClass.secondColor,
                    isExpanded: true,
                    icon: const Icon(Icons.people_outline),
                    hint: const Text('Turma'),
                    underline: Container(),
                    items: dataClass.map((turma) {
                      return DropdownMenuItem(
                        value: turma['id'],
                        child: Text(
                          turma['name'],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _classSelect = int.parse(value.toString());
                        _classVazio = false;

                        dataStudent = [];
                        getStudent();
                      });
                    },
                    value: _classSelect,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Aluno',
                  errorText: _studentVazio ? 'Informar o Aluno' : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: ThemeClass.secondColor,
                    ),
                  ),
                  fillColor: Colors.white,
                ),
                child: SizedBox(
                  height: 25,
                  child: DropdownButton(
                    enableFeedback: true,
                    borderRadius: BorderRadius.circular(18),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    focusColor: ThemeClass.primaryColor,
                    dropdownColor: ThemeClass.secondColor,
                    isExpanded: true,
                    icon: const Icon(Icons.people_outline),
                    hint: const Text('Aluno'),
                    underline: Container(),
                    items: dataStudent.map((student) {
                      return DropdownMenuItem(
                        value: student['id'],
                        child: Text(
                          student['name'],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _studentSelect = int.parse(value.toString());
                        _studentVazio = false;

                        searchGrade();
                      });
                    },
                    value: _studentSelect,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Nota',
                    errorText: _studentVazio ? 'Informar o Aluno' : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: ThemeClass.secondColor,
                      ),
                    ),
                    fillColor: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _notaController,
                    keyboardType: TextInputType.number,
                  )
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonApp(
        save: _save,
        showDelete: false,
        delete: () {},
      ),
    );
  }

  void searchGrade() async {
    _gradeStudent = await _gradeHelper.getByStudent(studentId: _studentSelect!);
    if (_gradeStudent != null) {
      grade = _gradeStudent!.grade;
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      //Seta variável de validação do professor
      if (_classSelect == null) {
        setState(() {
          _classVazio = true;
        });

        return;
      }

      if (_studentSelect == null) {
        setState(() {
          _studentVazio = true;
        });

        return;
      }

      if (grade == 0) {
        setState(() {
          gradeVazio = true;
        });

        return;
      }

      if (_gradeStudent == null) {
        _gradeHelper.insert(
          Grade(
              classe: _classSelect!,
              student: _studentSelect!,
              grade: double.parse(grade.toString())),
        );
      } else {
        _gradeStudent!.grade = double.parse(grade.toString());

        _gradeHelper.update(_gradeStudent!);
      }
      Fluttertoast.showToast(
        msg: "Registro Salvo com Sucesso.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ThemeClass.fifthColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.pop(context);
    }
  }
}
