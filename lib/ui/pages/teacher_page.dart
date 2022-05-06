import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  DateTime selectedDate = DateTime.now();

  final _raController = TextEditingController();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _bornDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Professores'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextInputDef(
              controller: _raController,
              validator: (value) {},
              labelText: 'RA',
            ),
            SizedBox(height: 10),
            TextInputDef(
              controller: _nameController,
              validator: (value) {},
              labelText: 'Nome',
            ),
            SizedBox(height: 10),
            TextInputDef(
              controller: _cpfController,
              validator: (value) {},
              labelText: 'CPF',
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child:TextInputDef(
                    controller: _bornDateController,
                    labelText: 'Data de Nascimento',
                    validator: (value) {},
                    keyboardType: TextInputType.none,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range_outlined),
                  onPressed: (){
                    _selectDate(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    print('ueeeeeeeeeeeeeeeeeeeeee');
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        _bornDateController.text = selectedDate.toString();
      });
  }
}
