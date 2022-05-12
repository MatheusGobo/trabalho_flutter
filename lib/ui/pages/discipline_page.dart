import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class DisciplinePage extends StatefulWidget {
  final Discipline? discipline;

  const DisciplinePage({this.discipline, Key? key}) : super(key: key);

  @override
  State<DisciplinePage> createState() => _DisciplinePageState();
}

class _DisciplinePageState extends State<DisciplinePage> {
  DateTime selectedDate = DateTime.now();

  final _disciplineHelper = DisciplineHelper();
  final _teacherHelper = TeacherHelper();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? _teacherSelect;
  bool _teacherVazio = false;
  List data = [];

  Future getTeachers() async {
    List result = json.decode(await _teacherHelper.getAllJson());
    setState(() {
      data = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getTeachers();

    if (widget.discipline != null) {
      _nameController.text = widget.discipline!.name;
      _teacherSelect       = widget.discipline!.teacher;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Disciplina'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextInputApp(
                controller: _nameController,
                validator: (value) {
                  return value!.isEmpty ? 'Informe o Nome' : null;
                },
                labelText: 'Nome',
                keyboardType: TextInputType.text,
                readOnly: false,
              ),
              const SizedBox(height: 10),
              InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Professor',
                    errorText: _teacherVazio ? 'Informar o Professor' : null,
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
                      hint: const Text('Professor'),
                      underline: Container(),
                      items: data.map((teachers) {
                        return DropdownMenuItem(
                          value: teachers['ra'],
                          child: Text(
                            teachers['name'],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _teacherSelect = int.parse(value.toString());
                          _teacherVazio = false;
                        });
                      },
                      value: _teacherSelect,
                    ),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonApp(
        save: _save,
        showDelete: widget.discipline != null,
        delete: _askDelete,
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      //Seta variável de validação do professor
      if (_teacherSelect == null) {
        setState(() {
          _teacherVazio = true;
        });

        return;
      }

      if (widget.discipline == null) {
        _disciplineHelper.insert(
          Discipline(
            name: _nameController.text,
            teacher: _teacherSelect!,
          ),
        );
      } else {
        widget.discipline!.name = _nameController.text;
        widget.discipline!.teacher = _teacherSelect!;

        _disciplineHelper.update(widget.discipline!);
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

  void _askDelete() {
    AlertMessage().deleteAlert(
      context: context,
      confirmDelete: _deleteDiscipline,
    );
  }

  void _deleteDiscipline() {
    _disciplineHelper.delete(widget.discipline!);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
