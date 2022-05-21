import 'package:flutter/material.dart';
import 'package:trabalho_flutter/app_theme.dart';
import 'package:trabalho_flutter/datasources/local/local.dart';
import 'package:trabalho_flutter/models/models.dart';
import 'package:trabalho_flutter/ui/pages/pages.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class CardClassMain extends StatefulWidget {
  const CardClassMain({Key? key}) : super(key: key);

  @override
  State<CardClassMain> createState() => _CardClassMainState();
}

class _CardClassMainState extends State<CardClassMain> {
  final _classMainHelper = ClassMainHelper();
  
  @override
  Widget build(BuildContext context) {
    final _classMainHelper = ClassMainHelper();

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Turmas'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _classMainHelper.getAll(),
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

              return _createList(context, snapshot.data as List<ClassMain>);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,
          color: Colors.white,
        ),
        backgroundColor: ThemeClass.primaryColor,
        onPressed: _openClassMain,
      ),
    );
  }

  void _openClassMain({ClassMain? classMain}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClassPage(
          classMain: classMain
        ),
      ),
    );
    setState(() {});
  }

  Widget _createList(BuildContext context, List<ClassMain> classMain) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: classMain.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          child: _createItemList(context, classMain[index]),
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
            _openClassMain(classMain: classMain[index]);
          },
        );
      },
    );
  }

  Widget _createItemList(BuildContext context, ClassMain classMain) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FieldCardApp(
                  prefix: 'Nome',
                  text: classMain.name,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FieldCardApp(
                  prefix: 'Regime',
                  text: _classMainHelper.getRegime(classMain.regime),
                ),
                const SizedBox(
                  width: 5,
                ),
                FieldCardApp(
                  prefix: 'Período',
                  text: _classMainHelper.getPeriod(classMain.period),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FieldCardApp(
                  prefix: 'Disciplina',
                  text: classMain.disciplines!,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}