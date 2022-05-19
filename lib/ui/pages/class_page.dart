import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';
import '../../models/models.dart';

class ClassPage extends StatefulWidget {
  final ClassMain? classMain;

  const ClassPage({this.classMain, Key? key}) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {

  final _disciplineHelper = DisciplineHelper();
  final _classHelper = ClassMainHelper();
  final _classDisciplineHelper = ClassDisciplineHelper();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? _periodoSelect;
  bool _periodoVazio = false;
  List dataPeriodo = [
    {"id": 0, "name": "Selecione o Período"},
    {"id": 1, "name": "Matutino"},
    {"id": 2, "name": "Vespertino"},
    {"id": 3, "name": "Noturno"}
  ];

  int? _regimeSelect;
  bool _regimeVazio = false;
  List dataRegime = [
    {"id": 0, "name": "Selecione o Período"},
    {"id": 1, "name": "Anual"},
    {"id": 2, "name": "Semestral"}
  ];

  bool _disciplinesVazio = false;
  List<String> disciplinesId = [];
  List<String> disciplinesName = [];
  List dataDiscipline = [];

  Future getDisciplines() async {
    List result = json.decode(await _disciplineHelper.getAllJson());
    setState(() {
      dataDiscipline = result;
    });
  }

  Future getLoadDisciplines(int classId) async {
    List<ClassDiscipline> result = await _classDisciplineHelper.getAllByClass(classId);
    setState(() {
        result.forEach((element) {
          disciplinesId.add(element.idDiscipline.toString());
          disciplinesName.add(element.nameDiscipline!);
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getDisciplines();

    if (widget.classMain != null) {
      _nameController.text = widget.classMain!.name;
      _periodoSelect       = widget.classMain!.period;
      _regimeSelect        = widget.classMain!.regime;

      getLoadDisciplines(widget.classMain!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Turma'),
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
                    return value!.isEmpty ? 'Informe o Nome da Turma' : null;
                  },
                  labelText: 'Nome',
                  keyboardType: TextInputType.text,
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Período',
                    errorText: _periodoVazio ? 'Informar o Período' : null,
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
                      //icon: const Icon(Icons.people_outline),
                      hint: const Text('Período'),
                      underline: Container(),
                      items: dataPeriodo.map((periodo) {
                        return DropdownMenuItem(
                          value: periodo['id'],
                          child: Text(
                            periodo['name'],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _periodoSelect = int.parse(value.toString());
                          _periodoVazio = false;
                        });
                      },
                      value: _periodoSelect,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Regime',
                    errorText: _regimeVazio ? 'Informar o Regime' : null,
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
                      //icon: const Icon(Icons.people_outline),
                      hint: const Text('Regime'),
                      underline: Container(),
                      items: dataRegime.map((regime) {
                        return DropdownMenuItem(
                          value: regime['id'],
                          child: Text(
                            regime['name'],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _regimeSelect = int.parse(value.toString());
                          _regimeVazio = false;
                        });
                      },
                      value: _regimeSelect,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Disciplina',
                    errorText: _disciplinesVazio ? 'Informar as Disciplinas' : null,
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
                      //icon: const Icon(Icons.people_outline),
                      hint: const Text('Disciplina'),
                      underline: Container(),
                    items: dataDiscipline.map((disciplina) {
                        return DropdownMenuItem(
                          value: disciplina['id'].toString(),
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              final _isSelecId = disciplinesId.contains(disciplina['id'].toString());
                              final _isSelecName = disciplinesName.contains(disciplina['name']);
                              _disciplinesVazio = false;
                              return InkWell(
                                onTap: () {
                                  _isSelecId ? disciplinesId.remove(disciplina['id'].toString())
                                             : disciplinesId.add(disciplina['id'].toString());
                                  _isSelecName ? disciplinesName.remove(disciplina['name'])
                                               : disciplinesName.add(disciplina['name']);
                                  //This rebuilds the StatefulWidget to update the button's text
                                  setState(() { });
                                  //This rebuilds the dropdownMenu Widget to update the check mark
                                  menuSetState(() {});
                                },
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      _isSelecId
                                          ? const Icon(Icons.check_box_outlined)
                                          : const Icon(Icons.check_box_outline_blank),
                                      const SizedBox(width: 16),
                                      Text(
                                        disciplina['name'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ).toList(),
                      onChanged: (value) {},
                      value: disciplinesId.isEmpty ? null : disciplinesId.last,
                      selectedItemBuilder: (context) {
                        return dataDiscipline.map((item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                disciplinesName.join(', '),
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            );
                          },
                        ).toList();
                      },
                    ),
                  ),
                ),/*
                Text(disciplinesName.toString()),
                SizedBox(height: 20,),
                Text(disciplinesId.toString()),
                */
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingButtonApp(
          save: _save,
          showDelete: widget.classMain != null,
          delete: _askDelete,
        ),
    );
  }

  void _save() async {
    if (_regimeSelect == 0) {
      setState(() {
        _regimeVazio = true;
      });

      return;
    }

    if (_periodoSelect == 0) {
      setState(() {
        _periodoVazio = true;
      });

      return;
    }

    if (disciplinesId.length == 0) {
      setState(() {
        _disciplinesVazio = true;
      });

      return;
    }

    if (_formKey.currentState!.validate()) {
      if (widget.classMain == null) {
        int classMainId = await _classHelper.insert(
          ClassMain(
            name: _nameController.text,
            regime: _regimeSelect!,
            period: _periodoSelect!
          ),
        );

        disciplinesId.forEach((element) {
          _classDisciplineHelper.insert(
              ClassDiscipline(
                  idClass: classMainId,
                  idDiscipline: int.parse(element)),
            );
          },
        );

      } else {
        widget.classMain!.name = _nameController.text;
        widget.classMain!.regime = _regimeSelect!;
        widget.classMain!.period = _periodoSelect!;

        ClassMain classMain = await _classHelper.update(widget.classMain!);

        _classDisciplineHelper.delete(classMain.id!);

        for (var element in disciplinesId) {
          _classDisciplineHelper.insert(
            ClassDiscipline(
                idClass: classMain.id!,
                idDiscipline: int.parse(element)
            ),
          );
        }
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
      confirmDelete: _deleteClass,
    );
  }

  void _deleteClass() {
    _classDisciplineHelper.delete(widget.classMain!.id!);
    _classHelper.delete(widget.classMain!);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
