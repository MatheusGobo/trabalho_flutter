import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:trabalho_flutter/app_theme.dart';

class FloatingButtonApp extends StatelessWidget {
  final VoidCallback save;
  final VoidCallback? delete;
  final bool showDelete;

  const FloatingButtonApp({
    required this.save,
    this.delete,
    required this.showDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: ThemeClass.primaryColor,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      children: [
        SpeedDialChild(
          backgroundColor: Colors.lightBlue,
          child: const Icon(Icons.save),
          label: 'Salvar',
          onTap: save,
        ),
        SpeedDialChild(
          visible: showDelete,
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.delete),
          label: 'Excluir',
          onTap: delete,
        ),
      ],
    );
  }
}