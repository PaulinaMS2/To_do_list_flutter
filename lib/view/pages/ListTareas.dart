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
           leading: Checkbox(
                  activeColor: Colors.teal.shade100, // Cambia el color aquí
                  value: tarea.completada,
                  onChanged: (bool? value) {
                    tareaProvider.tareaCompletada(tarea, value!);
                  },
                ),
          title: Text(tarea.nombre, style: const TextStyle(color: Colors.black, fontSize: 20)),
          trailing: IconButton(
            icon: Icon(Icons.visibility, color: Colors.black, size: 25),
            tooltip: "Ver tarea",
            onPressed: () => showTaskDetails(context, tarea, tareaProvider),
          ),
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

void showTaskDetails(BuildContext context, Tarea tarea, TareaProvider tareaProvider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(tarea.nombre, style: const TextStyle(color: Colors.black, fontSize: 25)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tarea.descripcion,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.lightBlue,),
                  onPressed: () {
                    // TODO: Implement edit functionality
                  },
                  tooltip: 'Editar',
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red,),
                  onPressed: () {
                    tareaProvider.deleteTarea(tarea);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListTareasPage()),
                      );
                  },
                  tooltip: 'Eliminar',
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}