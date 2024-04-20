class Tarea {
  String? id;
  String nombre;
  String descripcion;
  bool completada;
  Tarea({required this.nombre, required this.descripcion, required this.completada, this.id});
  Tarea.fromJson(Map<String, dynamic> json,String idTarea)
      : id = idTarea,
        nombre = json['name'],
        descripcion = json['description'],
        completada = json['done'];
}
