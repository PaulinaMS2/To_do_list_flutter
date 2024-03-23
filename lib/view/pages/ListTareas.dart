import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_flutter/controller/TareaProvider.dart';
import 'package:to_do_flutter/model/Tarea.dart';
import 'package:to_do_flutter/view/pages/EditTareaPage.dart';
import 'package:to_do_flutter/view/pages/widgets/appBarList.dart  ';
import 'package:to_do_flutter/view/pages/createTareaPage.dart';

class ListTareasPage extends StatefulWidget {
  @override
  _ListTareasPageState createState() => _ListTareasPageState();
}

class _ListTareasPageState extends State<ListTareasPage> {
  String title = "Listado de tareas";
  String _filter = "all";

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: appBarList("Lista de tareas"),
    body: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text('Todas', style: const TextStyle(color: Colors.black, fontSize: 13)),
                 // Cambia el color aquí
                leading: Radio<String>(
                  value: "all",
                  groupValue: _filter,
                  onChanged: (String? value) {
                    setState(() {
                      _filter = value!;
                    });
                  },
                  activeColor: _filter == "all" ? Colors.tealAccent.shade700: null,
                ),
              ),
            ),
           
            Expanded(
              child: ListTile(
                title: const Text('Completas', style: const TextStyle(color: Colors.black, fontSize: 13)),
                leading: Radio<String>(
                  value: "completed",
                  groupValue: _filter,
                  onChanged: (String? value) {
                    setState(() {
                      _filter = value!;
                    });
                  },
                  activeColor: _filter == "completed" ? Colors.tealAccent.shade700: null,
                ),
              ),
            ),
          
            Expanded(
              child: ListTile(
                title: const Text('Incompletas', style: const TextStyle(color: Colors.black, fontSize: 13)),
                leading: Radio<String>(
                  value: "incomplete",
                  groupValue: _filter,
                  onChanged: (String? value) {
                    setState(() {
                      _filter = value!;
                    });
                  },
                  activeColor: _filter == "incomplete" ? Colors.tealAccent.shade700: null,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Consumer<TareaProvider>(
            builder: (context, tareaProvider, child) {
              return listTareas(tareaProvider);
            },
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.cyan.shade50, // Cambia el color aquí
      child: const Icon(Icons.add, color: Colors.black),
      onPressed: () => loadCreateTareaPage(context),
    ),
  );
}

  ListView listTareas(TareaProvider tareaProvider) {
  List<Tarea> tareas;
  if (_filter == "all") {
    tareas = tareaProvider.tareas;
  } else if (_filter == "completed") {
    tareas = tareaProvider.obtenerTareasCompletas();
  } else {
    tareas = tareaProvider.obtenerTareasIncompletas();
  }

  return ListView.builder(
    itemCount: tareas.length,
    itemBuilder: (context, index) {
      Tarea tarea = tareas[index];
      return ListTile(
        leading: Checkbox(
          activeColor: Colors.teal.shade500, // Cambia el color aquí
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
              mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos horizontalmente
              children: [
                Center(
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.lightBlue,),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (context) => EditTareaPage(tarea: tarea),
                      ),
                      );
                    },
                    tooltip: 'Editar',
                  ),
                ),
                Center(
                  child: IconButton(
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
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
