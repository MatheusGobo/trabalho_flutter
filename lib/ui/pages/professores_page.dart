
import 'package:flutter/material.dart';
import 'package:trabalho_flutter/ui/widget/widgets.dart';

class ProfessoresPage extends StatelessWidget {
  const ProfessoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Professores'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
