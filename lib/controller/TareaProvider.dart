import 'package:flutter/foundation.dart';
import 'package:to_do_flutter/model/Tarea.dart';

class TareaProvider extends ChangeNotifier {
  List<Tarea> _tareas = [];

  List<Tarea> get tareas => _tareas;

  addTarea(Tarea tarea) {
    _tareas.add(tarea);
    notifyListeners();
  }
}