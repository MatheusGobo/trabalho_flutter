import 'package:flutter/material.dart';
import 'package:trabalho_flutter/ui/pages/cards/cards.dart';
import 'package:trabalho_flutter/ui/pages/pages.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.blue,
                  Colors.lightBlue,
                ],
              ),
            ),
            currentAccountPicture: Image.asset('assets/images/unipar_logo.png'),
            accountName: const Text(
              'Administrador',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            accountEmail: const Text(
              'admin@unipar.br',
              style: TextStyle(fontSize: 12),
            ),
          ),
          menuItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => selectedItem(context, 0),
          ),
          menuItem(
            icon: Icons.note_alt_outlined,
            text: 'Lançar Notas',
            onTap: () => selectedItem(context, 1),
          ),
          menuItem(
            icon: Icons.calendar_month_outlined,
            text: 'Lançar Frequência',
            onTap: () => selectedItem(context, 2),
          ),
          menuItem(
            icon: Icons.people_outline,
            text: 'Professores',
            onTap: () => selectedItem(context, 3),
          ),
          menuItem(
            icon: Icons.people_alt_outlined,
            text: 'Alunos',
            onTap: () => selectedItem(context, 4),
          ),
          menuItem(
            icon: Icons.menu_book_outlined,
            text: 'Disciplina',
            onTap: () => selectedItem(context, 5),
          ),
          menuItem(
            icon: Icons.class__outlined,
            text: 'Turmas',
            onTap: () => selectedItem(context, 6),
          ),
        ],
      ),
    );
  }

  Widget menuItem(
      {required String text, required IconData icon, VoidCallback? onTap}) {
    const color = Colors.blue;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      onTap: onTap,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
        );
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardTeacher(),
            ),
        );
        break;
      case 5:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDiscipline(),
            ),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassPage(),
          ),
        );
        break;
    }
  }
}
