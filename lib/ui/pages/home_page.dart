import 'package:flutter/material.dart';
import 'package:trabalho_flutter/ui/pages/cards/card_class_main.dart';
import 'package:trabalho_flutter/ui/pages/cards/card_discipline.dart';
import 'package:trabalho_flutter/ui/pages/cards/card_student.dart';
import 'package:trabalho_flutter/ui/pages/cards/card_teacher.dart';
import 'package:trabalho_flutter/ui/pages/pages.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: NavigationDrawerWidget(),
      body: Stack(
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade900,
                    Colors.blue.shade700,
                    Colors.blue.shade600,
                    Colors.blue.shade700,
                    Colors.blue.shade900
                  ]),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(200, 75),
                bottomLeft: Radius.elliptical(200, 75),
              ),
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.only(top: 40),
            child: Text('Unipar',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            alignment: Alignment.topCenter,
          ),
          Container(
            padding: EdgeInsets.only(top: 70, left: 15, right: 15, bottom: 10),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              primary: false,
              children: [
                cardMenu(context, text: "Lançar Frequencia", image: 'assets/images/frequencia.png', onTap: () => pageNavigation(context, FrequencePage())),
                cardMenu(context, text: "Lançar Notas", image: 'assets/images/notas.png', onTap: () => pageNavigation(context, TeacherPage())),
                cardMenu(context, text: "Professores", image: 'assets/images/professor.png', onTap: () => pageNavigation(context, CardTeacher())),
                cardMenu(context, text: "Alunos", image: 'assets/images/aluno.png', onTap: () => pageNavigation(context, CardStudent())),
                cardMenu(context, text: "Disciplinas", image: 'assets/images/disciplina.png', onTap: () => pageNavigation(context, CardDiscipline())),
                cardMenu(context, text: "Turmas", image: 'assets/images/turma_q.png', onTap: () => pageNavigation(context, CardClassMain())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardMenu(BuildContext context,
      {required String text, required String image, VoidCallback? onTap}) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 100,
            ),
            Text(text)
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  void pageNavigation(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }
}
