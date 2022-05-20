import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';
import '../../models/models.dart';

class StudentPage extends StatefulWidget {
  final StudentMain? studentMain;

  const StudentPage({this.studentMain, Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}
class _StudentPageState extends State<StudentPage> {
    DateTime selectedDateNasc = DateTime.now();
    DateTime selectedDateMatric = DateTime.now();

    final _studentHelper = StudentMainHelper();
    final _classHelper = ClassMainHelper();
    final _raController = TextEditingController();
    final _cpfController = TextEditingController();
    final _nameController = TextEditingController();
    final _dataMatricController = TextEditingController();
    final _dataNascController   = TextEditingController();
    final _formKey = GlobalKey<FormState>();


    int? _classSelect;
    bool _classVazio = false;

    List dataClass = [];

    Future getClasses() async {
      List result = json.decode(await _classHelper.getAllJson());
      setState(() {
        dataClass = result;
      });
    }

    @override
    void initState() {
      super.initState();
      getClasses();
      if (widget.studentMain != null) {
        _raController.text = widget.studentMain!.ra.toString();
        _cpfController.text =  widget.studentMain!.cpf;
        _nameController.text = widget.studentMain!.name;
        selectedDateNasc = widget.studentMain!.DtNasc;
        _dataNascController.text =
            SelectDate().formatTextDate(date: selectedDateNasc);
        selectedDateMatric = widget.studentMain!.DtMatric;
        _dataMatricController.text =
            SelectDate().formatTextDate(date: selectedDateMatric);
        _classSelect       = widget.studentMain!.classe;
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Aluno'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextInputApp(
                    controller: _raController,
                    validator: (value) {
                      return value!.isEmpty ? 'Informe o Ra do Aluno' : null;
                    },
                    labelText: 'RA',
                    keyboardType: TextInputType.number,
                    readOnly: false
                  ),
                  const SizedBox(height: 10),
                  TextInputApp(
                    controller: _cpfController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 14) {
                        return 'Informe o CPF.';
                      }
                    },
                    labelText: 'CPF',
                    mask: [
                      MaskTextInputFormatter(
                          mask: '###.###.###-##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy)
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    readOnly: false,
                  ),
                  const SizedBox(height: 10),
                  TextInputApp(
                    controller: _nameController,
                    validator: (value){
                      return value!.isEmpty ? 'Informe o nome do Aluno' : null;
                    },
                    labelText: 'Nome',
                    keyboardType: TextInputType.text,
                    readOnly:  false
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputApp(
                          controller: _dataNascController,
                          labelText: 'Data de Nascimento',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a Data de Nascimento.';
                            }

                            if (value.length < 10) {
                              return 'Informe uma data Completa';
                            }
                          },
                          keyboardType: TextInputType.none,
                          mask: [
                            MaskTextInputFormatter(
                                mask: '##/##/####',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy
                            )
                          ],
                          readOnly: true,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_month_outlined),
                        onPressed: () async {
                          await SelectDate().selectDate(
                              context: context,
                              actualDate: selectedDateNasc).then((value) {
                            setState(() {
                              selectedDateNasc = value!;
                              _dataNascController.text = SelectDate()
                                  .formatTextDate(date: selectedDateNasc);
                            });
                          },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputApp(
                          controller: _dataMatricController,
                          labelText: 'Data de Matricula',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a Data de Matricula.';
                            }

                            if (value.length < 10) {
                              return 'Informe uma data Completa';
                            }
                          },
                          keyboardType: TextInputType.none,
                          mask: [
                            MaskTextInputFormatter(
                              mask: '##/##/####',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy
                            )
                          ],
                          readOnly: true,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_month_outlined),
                        onPressed: () async {
                          await SelectDate().selectDate(
                              context: context,
                              actualDate: selectedDateMatric).then((value) {
                            setState(() {
                              selectedDateMatric = value!;
                              _dataMatricController.text = SelectDate()
                                  .formatTextDate(date: selectedDateMatric);
                            });
                          },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                        items: dataClass.map((classes) {
                          return DropdownMenuItem(
                            value: classes['id'],
                            child: Text(
                              classes['name'],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _classSelect = int.parse(value.toString());
                            _classVazio = false;
                          });
                        },
                        value: _classSelect,
                      ),
                    ),
                  ),
                ],
              )
            )
        ),
        ),
        floatingActionButton: FloatingButtonApp(
        save: _save,
        showDelete: widget.studentMain != null,
        delete: _askDelete,
      ),
      );
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

        if (widget.studentMain == null) {
          _studentHelper.insert(
            StudentMain(
              ra: int.parse(_raController.text),
              cpf: _cpfController.text,
              name: _nameController.text,
              DtNasc: selectedDateNasc,
              DtMatric: selectedDateMatric,
              classe: _classSelect!,
            ),
          );
        } else {

          widget.studentMain!.ra = int.parse(_raController.text);
          widget.studentMain!.cpf = _cpfController.text;
          widget.studentMain!.name = _nameController.text;
          widget.studentMain!.DtNasc = selectedDateNasc;
          widget.studentMain!.DtMatric = selectedDateMatric;
          widget.studentMain!.classe = _classSelect!;

          _studentHelper.update(widget.studentMain!);
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
        confirmDelete: _deleteStudent,
      );
    }

    void _deleteStudent() {
      _studentHelper.delete(widget.studentMain!);
      Navigator.pop(context);
      Navigator.pop(context);
    }
}


