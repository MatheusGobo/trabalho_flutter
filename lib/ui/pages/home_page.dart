import 'package:flutter/material.dart';
import 'package:trabalho_flutter/ui/components/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.blue,
                    Colors.lightBlue
                  ]
                )
              ),
              currentAccountPicture: Image.asset('assets/images/unipar_logo.png'),
              accountName: const Text('Administrador',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              accountEmail: const Text('admin@unipar.br',
                style: TextStyle(fontSize: 12),
              ),
            ),
            ItemListMenu(
              icon: Icons.home,
              text: 'Home',
              onTap: () {},
            ),
            ItemListMenu(
              icon: Icons.note_alt_outlined,
              text: 'Lançar Notas',
              onTap: () {},
            ),
            ItemListMenu(
              icon: Icons.calendar_month_outlined,
              text: 'Lançar Frequência',
              onTap: () {},
            ),
            ItemListMenu(
              icon: Icons.people_outline,
              text: 'Professores',
              onTap: () {},
            ),
            ItemListMenu(
              icon: Icons.people_alt_outlined,
              text: 'Alunos',
              onTap: () {},
            ),
            ItemListMenu(
              icon: Icons.menu_book_outlined,
              text: 'Disciplina',
              onTap: () {},
            ),
            ItemListMenu(
              icon: Icons.class__outlined,
              text: 'Turmas',
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
