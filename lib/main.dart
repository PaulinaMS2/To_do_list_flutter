import 'package:flutter/material.dart';
import 'package:to_do_flutter/view/pages/ListTareas.dart';
import 'package:flutter/material.dart';
import 'package:to_do_flutter/controller/TareaProvider.dart';
import 'package:to_do_flutter/view/pages/CreateTareaPage.dart';
import 'package:to_do_flutter/view/pages/ListTareas.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TareaProvider()),
    ],
    child: MainApp(),
  ));
}


class MainApp extends StatelessWidget {
  String title = "Contactos";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListTareasPage(),
      ),
    );
  }
}
