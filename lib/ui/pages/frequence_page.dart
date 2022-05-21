import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class FrequencePage extends StatefulWidget {

  const FrequencePage({Key? key}) : super(key: key);

  @override
  State<FrequencePage> createState() => _FrequencePageState();
}

class _FrequencePageState extends State<FrequencePage> {

  final _frequenceHelper   = FrequenceHelper();
  final _classMainHelper   = ClassMainHelper();
  final _studentMainHelper = StudentMainHelper();
  final _formKey = GlobalKey<FormState>();

  Frequence? _freqStudent;

  double percentFrequence = 0.0;
  bool frequenceVazio = false;

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
        title: const Text('Frequência'),
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
              SizedBox(height: 10,),
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

                        searchFrequence();
                      });
                    },
                    value: _studentSelect,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InputDecorator(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  labelText: 'Frequência',
                  errorText: frequenceVazio ? 'Informar a Turma' : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: ThemeClass.secondColor,
                    ),
                  ),
                  fillColor: Colors.white,
                ),
                child: SizedBox(
                  height: 22,
                  child: Row(
                    children: [
                      Expanded(
                        child: Slider(
                        label: percentFrequence.round().toString(),
                        activeColor: ThemeClass.primaryColor,
                        thumbColor: ThemeClass.fifthColor,
                        inactiveColor: ThemeClass.fourthColor,
                        min: 0,
                        max: 100,
                        divisions: 20,
                        value: percentFrequence,
                        onChanged: (newPercent) {
                          setState(() {
                            percentFrequence = newPercent;
                            frequenceVazio = false;
                          });
                        },
                      ),
                      ),
                      Text(
                        percentFrequence.round().toString(),
                        style: const TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ],
                  )
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

  void searchFrequence() async {
    _freqStudent = await _frequenceHelper.getByStudent(studentId: _studentSelect!);
    if (_freqStudent != null) {
      percentFrequence = _freqStudent!.percent;
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

      if (percentFrequence == 0) {
        setState(() {
          frequenceVazio = true;
        });

        return;
      }

      if (_freqStudent == null) {
        _frequenceHelper.insert(
          Frequence(
              classe: _classSelect!,
              student: _studentSelect!,
              percent: double.parse(percentFrequence.round().toString())
          ),
        );
      } else {
        _freqStudent!.percent = double.parse(percentFrequence.round().toString());

        _frequenceHelper.update(_freqStudent!);

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
