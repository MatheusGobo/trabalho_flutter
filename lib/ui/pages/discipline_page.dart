import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';
import '../../models/models.dart';

class DisciplinePage extends StatefulWidget {
  final Discipline? discipline;

  const DisciplinePage({this.discipline, Key? key}) : super(key: key);

  @override
  State<DisciplinePage> createState() => _DisciplinePageState();
}

class _DisciplinePageState extends State<DisciplinePage> {
  DateTime selectedDate = DateTime.now();

  final disciplineHelper = DisciplineHelper();
  final _nameController = TextEditingController();
  final _teacherController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.discipline != null) {
      _nameController.text = widget.discipline!.name;
      //_cpfController.text = widget.teacher!.cpf;
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
                controller: _nameController,
                validator: (value) {
                  return value!.isEmpty ? 'Informe o Nome' : null;
                },
                labelText: 'Name',
                keyboardType: TextInputType.number,
                readOnly: false,
              ),
              const SizedBox(height: 10),
                ],
              ),
          ),
        ),
      );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      if (widget.discipline == null || _nameController.text != widget.discipline!.name.toString()) {
        disciplineHelper.inserir(Discipline(
          name: _nameController.text,
          teacher: _teacherController.hashCode
        ));

      } else {
        widget.discipline!.name = _nameController.text;
        widget.discipline!.teacher = _teacherController.hashCode;

        disciplineHelper.update(widget.discipline!);
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
        confirmDelete: _deleteDiscipline
      );
    }
  }

  void _deleteDiscipline() {
    disciplineHelper.delete(widget.discipline!);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
