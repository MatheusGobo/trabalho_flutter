import 'package:flutter/material.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';
import 'package:trabalho_flutter/ui/pages/pages.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class CardTeacher extends StatefulWidget {
  const CardTeacher({Key? key}) : super(key: key);

  @override
  State<CardTeacher> createState() => _CardTeacherState();
}

class _CardTeacherState extends State<CardTeacher> {
  @override
  Widget build(BuildContext context) {
    final _teacherHelper = TeacherHelper();
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Professores'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _teacherHelper.getTodos(),
        //Metodo que irá retorar os dados para o FutureBuilder
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }

              return _createList(context, snapshot.data as List<Teacher>);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: ThemeClass.primaryColor,
        onPressed: _openTeacher,
      ),
    );
  }

  void _openTeacher({Teacher? teacher}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeacherPage(
          teacher: teacher,
        ),
      ),
    );
    setState(() {});
  }

  Widget _createList(BuildContext context, List<Teacher> teacher) {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: teacher.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _createItemList(context, teacher[index]),
            background: Container(
              color: Colors.green[300],
              child: Row(
                children: const [
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    'Editar',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            secondaryBackground: Container(
              color: Colors.green[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Editar',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            onDismissed: (DismissDirection direction) {
              _openTeacher(teacher: teacher[index]);
            },
          );
        });
  }

  Widget _createItemList(BuildContext context, Teacher teacher) {
    final _raController = TextEditingController();
    _raController.text = teacher.ra.toString();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FieldCardApp(
                  width: MediaQuery.of(context).size.width * 0.35,
                  prefix: 'RA: ',
                  text: teacher.ra.toString(),
                ),
                Expanded(child: Container()),
                FieldCardApp(
                  width: MediaQuery.of(context).size.width * 0.5,
                  prefix: 'CPF: ',
                  text: teacher.cpf,
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            FieldCardApp(
              width: double.infinity,
              prefix: 'Nome: ',
              text: teacher.name,
            ),
            const SizedBox(
              height: 3,
            ),
            FieldCardApp(
              width: double.infinity,
              prefix: 'Data de Nascimento: ',
              text: '${SelectDate().formatTextDate(date: teacher.bornDate)}',
            ),
          ],
        ),
      ),
    );
  }
}