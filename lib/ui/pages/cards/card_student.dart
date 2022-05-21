import 'package:flutter/material.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';
import 'package:trabalho_flutter/ui/pages/pages.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class CardStudent extends StatefulWidget {
  const CardStudent({Key? key}) : super(key: key);

  @override
  State<CardStudent> createState() => _CardStudentState();
}

class _CardStudentState extends State<CardStudent> {
  @override
  Widget build(BuildContext context) {
    final _studentHelper = StudentMainHelper();
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Alunos'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _studentHelper.getAll(),
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

              return _createList(context, snapshot.data as List<StudentMain>);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: ThemeClass.primaryColor,
        onPressed: _openStudent,
      ),
    );
  }

  void _openStudent({StudentMain? student}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentPage(
          studentMain: student,
        ),
      ),
    );
    setState(() {});
  }

  Widget _createList(BuildContext context, List<StudentMain> student) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: student.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          child: _createItemList(context, student[index]),
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
            _openStudent(student: student[index]);
          },
        );
      },
    );
  }

  Widget _createItemList(BuildContext context, StudentMain student) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FieldCardApp(
                  prefix: 'RA',
                  text: student.ra.toString(),
                ),
                const SizedBox(
                  width: 10,
                ),
                FieldCardApp(
                  prefix: 'CPF',
                  text: student.cpf,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FieldCardApp(
                  prefix: 'Nome',
                  text: student.name,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FieldCardApp(
                  prefix: 'Turma',
                  text: student.className!,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FieldCardApp(
                  prefix: 'Data de Nascimento',
                  text:
                  '${SelectDate().formatTextDate(date: student.DtNasc)}',
                ),
                const SizedBox(
                  width: 5,
                ),
                FieldCardApp(
                  prefix: 'Data de Matricula',
                  text:
                  '${SelectDate().formatTextDate(date: student.DtMatric)}',
                ),
              ],
            ),
            Visibility(
              visible: (student.frequence! > 0 && student.average! > 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FieldCardApp(
                        prefix: 'Status',
                        text: approvedStudent(
                          percentFreq: student.frequence!,
                          media: student.average!,
                        ) ? 'Reprovado' : 'Aprovado',
                        textColor: approvedStudent(
                          percentFreq: student.frequence!,
                          media: student.average!, // TODO Tem que pegar o certo depois de implementado
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FieldCardApp(
                        prefix: 'Média: ',
                        text: '${student.average}',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      FieldCardApp(
                        prefix: 'Frequência',
                        text: '${student.frequence}%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool approvedStudent({double? percentFreq, double? media}) {
    if (percentFreq != null && media != null) {
      if (percentFreq < 70 || (media < 60)) {
        return true;
      }
    }
    return false;
  }
}