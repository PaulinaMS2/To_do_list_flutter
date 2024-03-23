import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_flutter/controller/TareaProvider.dart';
import 'package:to_do_flutter/model/Tarea.dart';
import 'package:to_do_flutter/view/pages/ListTareas.dart';


String? validatorNombre(String? nombre) {
  if (nombre == null || nombre!.isEmpty) {
    return "El nombre de la tarea es obligatorio";
  }
  return null;
}

String? validatorDescripcion(String? descripcion) {
  if (descripcion == null || descripcion!.isEmpty) {
    return "La descripción de la tarea es obligatoria";
  }
  return null;
}

saveTarea(GlobalKey<FormState> _key,
    {required String? nombre, required String? descripcion, required TareaProvider provider}) {
  // Lógica
  if (_key.currentState!.validate()) {
    _key.currentState!.save();
    if (nombre != null && descripcion != null) {
      print(nombre);
      Tarea tarea = Tarea( nombre, descripcion, false);
      provider.addTarea(tarea);

    }
  }
}

