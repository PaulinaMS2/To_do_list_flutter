import 'package:flutter/material.dart';
import 'package:to_do_flutter/controller/TareaController.dart';
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
    {required String? nombre, required String? descripcion}) {
  if (_key.currentState!.validate()) {
    _key.currentState!.save();
    if (nombre != null && descripcion != null) {
      Tarea tarea = Tarea(nombre: nombre, descripcion: descripcion, completada: false);
      TareaController tareaController = TareaController();
      tareaController.createTarea(tarea);
      
    }
  }
}

