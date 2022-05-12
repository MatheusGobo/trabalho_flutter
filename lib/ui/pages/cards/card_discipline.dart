import 'package:flutter/material.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';
import 'package:trabalho_flutter/ui/pages/pages.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class CardDiscipline extends StatefulWidget {
  const CardDiscipline({Key? key}) : super(key: key);

  @override
  State<CardDiscipline> createState() => _CardDisciplineState();
}

class _CardDisciplineState extends State<CardDiscipline> {
  final _teacherHelper = TeacherHelper();
  
  @override
  Widget build(BuildContext context) {
    final _disciplineHelper = DisciplineHelper();    
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Disciplinas'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _disciplineHelper.getAll(),
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
              
              return _createList(context, snapshot.data as List<Discipline>);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,
          color: Colors.white,
        ),
        backgroundColor: ThemeClass.primaryColor,
        onPressed: _openTeacher,
      ),
    );
  }

  void _openTeacher({Discipline? discipline}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisciplinePage(
          discipline: discipline,
        ),
      ),
    );
    setState(() {});
  }

  Widget _createList(BuildContext context, List<Discipline> discipline) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: discipline.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          child: _createItemList(context, discipline[index]),
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
            _openTeacher(discipline: discipline[index]);
          },
        );
      },
    );
  }

  Widget _createItemList(BuildContext context, Discipline discipline) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldCardApp(
              width: double.infinity,
              prefix: 'Nome: ',
              text: discipline.name,
            ),
            const SizedBox(
              height: 3,
            ),
            FieldCardApp(
              width: double.infinity,
              prefix: 'Professor: ',
              text: discipline.nameTeacher!,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> nameTeacher(int ra) async{
    Teacher teacher = await _teacherHelper.getByRa(ra);
    return teacher.name;
  }
}