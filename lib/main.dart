import 'package:flutter/material.dart';
import 'package:to_do_flutter/view/pages/ListTareas.dart';
import 'package:flutter/material.dart';
// import 'package:to_do_flutter/controller/TareaProvider.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_flutter/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ).then((value) => runApp(const MainApp()));
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});
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
