import 'package:flutter/material.dart';
import 'package:trabalho_flutter/app_theme.dart';

class AlertMessage {
  static Future show({required BuildContext context,
                      required Widget title,
                      required String text,
                      required List<Widget> bottons}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: title,
            content: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              ),
            ),
            actions: bottons,
          );
        },
    );
  }

  void deleteAlert({required BuildContext context, required VoidCallback confirmDelete}){
    AlertMessage.show(
        context: context,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.dangerous_outlined,
              color: Colors.red,
              size: 60,
            ),
            SizedBox(width: 5,),
            Text('Atenção')
          ],
        ),
        text: 'Deseja excluir o registro ?',
        bottons: [
          TextButton(
            child: Text('Sim',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            onPressed: confirmDelete,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return ThemeClass.primaryColor; // Use the component's default.
                },
              ),
            ),
            child: Text('Não',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]
    );
  }
}
