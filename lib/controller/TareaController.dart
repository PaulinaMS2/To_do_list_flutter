import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_flutter/model/Tarea.dart';

class TareaController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final String collection = "tareas";

  Future<void> createTarea(Tarea tarea) async {
    try {
      await db.collection(collection).add({
        "nombre": tarea.nombre,
        "descripcion": tarea.descripcion,
        "completada": tarea.completada
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> tareaCompletada(String id, bool completada) async {
    try {
      await db.collection(collection).doc(id).update({
        'completada': completada,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTarea(String id) async {
    try {
      await db.collection(collection).doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTarea(String id, {required String nombre, required String descripcion}) async {
    try {
      await db.collection(collection).doc(id).update({
        "nombre": nombre,
        "descripcion": descripcion,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Tarea>> getTareas() async {
    List<Tarea> tareas = [];
    try {
      await db.collection(collection).get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          tareas.add(Tarea(
            id: element.id,
            nombre: element["nombre"],
            descripcion: element["descripcion"],
            completada: element["completada"],
          ));
        }
      });
    } catch (e) {
      print(e);
    }
    return tareas;
  }
}