import 'package:flutter/material.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child:
            Text('Unipar', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
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
                cardMenu(text: "Aluno", image: 'assets/images/aluno.png'),
                cardMenu(text: "Aluno", image: 'assets/images/aluno.png'),
                cardMenu(text: "Aluno", image: 'assets/images/aluno.png'),
                cardMenu(text: "Aluno", image: 'assets/images/aluno.png'),
                cardMenu(text: "Aluno", image: 'assets/images/aluno.png'),
                cardMenu(text: "Aluno", image: 'assets/images/aluno.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardMenu(
      {required String text, required String image, VoidCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset(image), Text(text)],
      ),
    );
  }
}
