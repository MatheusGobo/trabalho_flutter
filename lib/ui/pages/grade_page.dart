import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
  final _nota1Controller = TextEditingController();
  final _nota2Controller = TextEditingController();
  final _nota3Controller = TextEditingController();
  final _nota4Controller = TextEditingController();

  Grade? _gradeStudent;
  ClassMain? _classMain;
  bool semestral = true;

  int? _classSelect;
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
    List result = json.decode(await _studentMainHelper.getByClassJson(classId: _classSelect!));
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
                        searchClassMain();
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
              Row(
                children: [
                  Expanded(
                    child: TextInputApp(
                      controller: _nota1Controller,
                      labelText: 'Nota 1',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a Nota.';
                        }

                        if (int.parse(value) > 100) {
                          return 'A nota deve ser menor que 100.';
                        }
                      },
                      readOnly: false,
                      keyboardType: TextInputType.number,
                      mask: [
                        MaskTextInputFormatter(
                            mask: '###',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextInputApp(
                      controller: _nota2Controller,
                      labelText: 'Nota 2',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a Nota.';
                        }

                        if (int.parse(value) > 100) {
                          return 'A nota deve ser menor que 100.';
                        }
                      },
                      readOnly: false,
                      keyboardType: TextInputType.number,
                      mask: [
                        MaskTextInputFormatter(
                            mask: '###',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Visibility(
                    visible: !semestral,
                    child: Expanded(
                      child: TextInputApp(
                        controller: _nota3Controller,
                        labelText: 'Nota 3',
                        validator: (value) {
                          if (value!.isEmpty && semestral) {
                            return 'Informe a Nota.';
                          }

                          if (int.parse(value) > 100) {
                            return 'A nota deve ser menor que 100.';
                          }
                        },
                        readOnly: false,
                        keyboardType: TextInputType.number,
                        mask: [
                          MaskTextInputFormatter(
                              mask: '###',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Visibility(
                    visible: !semestral,
                    child: Expanded(
                      child: TextInputApp(
                        controller: _nota4Controller,
                        labelText: 'Nota 4',
                        validator: (value) {
                          if (value!.isEmpty && semestral) {
                            return 'Informe a Nota.';
                          }

                          if (int.parse(value) > 100) {
                            return 'A nota deve ser menor que 100.';
                          }
                        },
                        readOnly: false,
                        keyboardType: TextInputType.number,
                        mask: [
                          MaskTextInputFormatter(
                              mask: '###',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
      _nota1Controller.text = _gradeStudent!.grade1.round().toString();
      _nota2Controller.text = _gradeStudent!.grade2.round().toString();
      _nota3Controller.text = _gradeStudent!.grade3!.round().toString();
      _nota4Controller.text = _gradeStudent!.grade4!.round().toString();
    }
  }

  void searchClassMain() async {
    _classMain = await _classMainHelper.getById(classId: _classSelect!);
    if (_classMain != null) {
      semestral = _classMain!.regime == 2;
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

      if (_gradeStudent == null) {
        _gradeHelper.insert(
          Grade(
              classe: _classSelect!,
              student: _studentSelect!,
              grade1: double.parse(_nota1Controller.text),
              grade2: double.parse(_nota2Controller.text),
              grade3: double.tryParse(_nota3Controller.text),
              grade4: double.tryParse(_nota4Controller.text)),
        );
      } else {
        _gradeStudent!.grade1 = double.parse(_nota1Controller.text);
        _gradeStudent!.grade2 = double.parse(_nota2Controller.text);
        _gradeStudent!.grade3 = double.tryParse(_nota3Controller.text);
        _gradeStudent!.grade4 = double.tryParse(_nota4Controller.text);

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
