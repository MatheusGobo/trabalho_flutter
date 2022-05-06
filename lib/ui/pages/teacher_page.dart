import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';
import '../../models/models.dart';

class TeacherPage extends StatefulWidget {
  final Teacher? teacher;

  const TeacherPage({this.teacher, Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  DateTime selectedDate = DateTime.now();

  final teacherHelper = TeacherHelper();
  final _raController = TextEditingController();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.teacher != null) {
      _raController.text = widget.teacher!.ra.toString();
      _nameController.text = widget.teacher!.name;
      _cpfController.text = widget.teacher!.cpf;
      selectedDate = widget.teacher!.bornDate;
      _bornDateController.text = SelectDate().formatTextDate(
          date: selectedDate
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Professor'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextInputApp(
                controller: _raController,
                validator: (value) {
                  return value!.isEmpty ? 'Informe o RA' : null;
                },
                labelText: 'RA',
                keyboardType: TextInputType.number,
                mask: [
                  MaskTextInputFormatter(
                    mask: '##########',
                    filter: { "#": RegExp(r'[0-9]') },
                    type: MaskAutoCompletionType.lazy
                  ),
                ],
                readOnly: false,
              ),
              const SizedBox(height: 10),
              TextInputApp(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o Nome.';
                  }

                  if (value.length > 60) {
                    return 'Máximo 60 Caracteres';
                  }
                },
                labelText: 'Nome',
                readOnly: false,
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
                mask: [MaskTextInputFormatter(
                    mask: '###.###.###-##',
                    filter: { "#": RegExp(r'[0-9]') },
                    type: MaskAutoCompletionType.lazy
                )],
                keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                readOnly: false,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child:TextInputApp(
                      controller: _bornDateController,
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
                      mask: [MaskTextInputFormatter(
                          mask: '##/##/####',
                          filter: { "#": RegExp(r'[0-9]') },
                          type: MaskAutoCompletionType.lazy
                      )],
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.date_range_outlined),
                    onPressed: () async {
                      await SelectDate().selectDate(
                        context: context,
                        actualDate: selectedDate
                      ).then((value) {
                        setState(() {
                          selectedDate = value!;
                          _bornDateController.text = SelectDate().formatTextDate(
                            date: selectedDate
                          );
                        });
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButtonApp(
        save: _save,
        showDelete: widget.teacher != null,
        delete: _askDelete,
      )
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      if (widget.teacher == null || _raController.text != widget.teacher!.ra.toString()) {
        teacherHelper.inserir(Teacher(
          ra: int.parse(_raController.text),
          name: _nameController.text,
          cpf: _cpfController.text,
          bornDate: selectedDate
        ));

      } else {
        widget.teacher!.ra = int.parse(_raController.text);
        widget.teacher!.name = _nameController.text;
        widget.teacher!.cpf = _cpfController.text;
        widget.teacher!.bornDate = selectedDate;

        teacherHelper.update(widget.teacher!);
      }

      Fluttertoast.showToast(
          msg: "Registro Salvo com Sucesso.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ThemeClass.fifthColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pop(context);
    }
  }


  void _askDelete() {
    if (_formKey.currentState!.validate()) {
      AlertMessage().deleteAlert(
        context: context,
        confirmDelete: _deleteTeacher
      );
    }
  }

  void _deleteTeacher() {
    teacherHelper.delete(widget.teacher!);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
