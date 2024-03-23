import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_flutter/controller/TareaProvider.dart';
import 'package:to_do_flutter/model/Tarea.dart';
import 'package:to_do_flutter/view/pages/widgets/appBarList.dart  ';
import 'package:to_do_flutter/view/pages/createTareaPage.dart';

class ListTareasPage extends StatelessWidget {
  String title = "Listado de tareas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarList("Lista de tareas"),
      body: Consumer<TareaProvider>(
        builder: (context, tareaProvider, child) {
          return listTareas(tareaProvider);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan.shade50, // Cambia el color aquí
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () => loadCreateTareaPage(context),
      ),
    );
  }

  ListView listTareas(TareaProvider tareaProvider) {
    List<Tarea> tareas = tareaProvider.tareas;
    return ListView.builder(
      itemCount: tareas.length,
      itemBuilder: (context, index) {
        Tarea tarea = tareas[index];
        return ListTile(
          title: Text(tarea.nombre),
          subtitle: Text(tarea.descripcion),
        );
      },
    );
  }

  loadCreateTareaPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateTareaPage(),
      ),
    );
  }
}