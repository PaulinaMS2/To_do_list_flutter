import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_flutter/controller/TareaProvider.dart';
import 'package:to_do_flutter/controller/createController.dart';
import 'package:to_do_flutter/view/pages/widgets/appBarList.dart';
import 'package:to_do_flutter/view/pages/ListTareas.dart';

class CreateTareaPage extends StatefulWidget {
  @override
  State<CreateTareaPage> createState() => _CreateTareaPageState();
}

class _CreateTareaPageState extends State<CreateTareaPage> {
  GlobalKey<FormState> _key = GlobalKey();

  String? nombre = "";
  String? descripcion = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: appBarList('Crear'),
      body: Consumer<TareaProvider>(
        builder: (context, tareaProvider, child) => tareaForm(context,tareaProvider),
      ),
    );
  }

  Widget tareaForm(BuildContext context, TareaProvider tareaProvider) {
  return Container(
    alignment: Alignment.center,
    child: Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Nueva tarea", style: const TextStyle(color: Colors.black, fontSize: 25)),
              TextFormField(
                onChanged: (newValue) => nombre = newValue,
                validator: validatorNombre,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  hintText: "Ingrese un nombre para la tarea",
                ),
              ),
              TextFormField(
                onChanged: (newValue) => descripcion = newValue,
                decoration: const InputDecoration(
                  labelText: "Descripcion",
                  hintText: "Ingrese una descripción de la tarea",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListTareasPage()),
                      );
                    },
                    child: Text("Cancelar", style: const TextStyle(color: Colors.red, fontSize: 20)),
                  ),
                  SizedBox(width: 10), // Add some spacing between the buttons
                  TextButton(
                    onPressed: () {
                      saveTarea(
                        _key,
                        nombre: nombre,
                        descripcion: descripcion,
                        provider: tareaProvider,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListTareasPage()),
                      );
                    },
                    child: Text("Guardar tarea", style: const TextStyle(color: Colors.teal, fontSize: 20)),
                  ), // Add some spacing between the buttons
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}