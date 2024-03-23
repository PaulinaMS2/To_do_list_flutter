import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_flutter/controller/TareaProvider.dart';
import 'package:to_do_flutter/controller/createController.dart';
import 'package:to_do_flutter/view/pages/widgets/appBarList.dart';
import 'package:to_do_flutter/view/pages/ListTareas.dart';
import 'package:to_do_flutter/model/Tarea.dart';


class EditTareaPage extends StatefulWidget {
  final Tarea tarea;

  const EditTareaPage({Key? key, required this.tarea}) : super(key: key);

  @override
  State<EditTareaPage> createState() => _EditTareaPageState();
}

class _EditTareaPageState extends State<EditTareaPage> {
  final GlobalKey<FormState> _key = GlobalKey();

  late String nombre;
  late String descripcion;

  @override
  void initState() {
    super.initState();
    nombre = widget.tarea.nombre;
    descripcion = widget.tarea.descripcion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: appBarList('Editar'),
      body: Consumer<TareaProvider>(
        builder: (context, tareaProvider, child) => editTareaForm(context, tareaProvider),
      ),
    );
  }

  Widget editTareaForm(BuildContext context, TareaProvider tareaProvider) {
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
              Text("Editar tarea", style: const TextStyle(color: Colors.black, fontSize: 25)),
              TextFormField(
                onChanged: (newValue) => nombre = newValue,
                validator: validatorNombre,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  
                ),
              ),
              TextFormField(
                onChanged: (newValue) => descripcion = newValue,
                decoration: const InputDecoration(
                  labelText: "Descripcion",
                  
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
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        tareaProvider.updateTarea(widget.tarea,
                        nombre: nombre, descripcion: descripcion);
                        Navigator.pop(context);
                };
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListTareasPage()),
                );
              },
                    child: Text("Guardar cambios", style: const TextStyle(color: Colors.teal, fontSize: 20)),
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