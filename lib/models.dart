// ignore_for_file: avoid_print

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/drift_database.dart';

class RegistroPom {
  // REGISTROS POMODORO
  String nombreSesionP;
  DateTime fechaP;
  DateTime inicSesionP;
  DateTime finSesionP;
  int pomodorosP;
  int numRondasP;
  String tiempoSesionP;
  String anotacionesP;

  RegistroPom.empty()
      : nombreSesionP = '',
        fechaP = DateTime(0),
        inicSesionP = DateTime(0),
        finSesionP = DateTime(0),
        pomodorosP = 0,
        numRondasP = 0,
        tiempoSesionP = '',
        anotacionesP = '';

  RegistroPom(
      {required this.nombreSesionP,
      required this.fechaP,
      required this.inicSesionP,
      required this.finSesionP,
      required this.pomodorosP,
      required this.numRondasP,
      required this.tiempoSesionP,
      required this.anotacionesP});
}

class RegistroFlow {
  // REGISTROS FLOWTIME
  String nombreF;
  DateTime fechaF;
  DateTime inicSesionF;
  DateTime finSesionF;
  int internas;
  int externas;
  String tiempoSesionF;
  String anotacionesF;

  RegistroFlow.empty()
      : nombreF = '',
        fechaF = DateTime(0),
        inicSesionF = DateTime(0),
        finSesionF = DateTime(0),
        internas = 0,
        externas = 0,
        tiempoSesionF = '',
        anotacionesF = '';

  RegistroFlow(
      {required this.nombreF,
      required this.fechaF,
      required this.inicSesionF,
      required this.finSesionF,
      required this.internas,
      required this.externas,
      required this.tiempoSesionF,
      required this.anotacionesF});
}

class ProyectoModel extends ChangeNotifier {
  List<ProyectoData> _proyectos = [];

  List<ProyectoData> get proyectos => _proyectos;

  void setProyectos(List<ProyectoData> proyectosData) {
    _proyectos = proyectosData;
    notifyListeners();
  }

  void addProyecto(ProyectoData proyecto) {
    _proyectos.add(proyecto);
    notifyListeners();
  }

  void removeProyecto(ProyectoData proyecto) {
    _proyectos.remove(proyecto);
    notifyListeners();
  }

  void setNuevoNombreProyecto(ProyectoData proyecto, String nuevoNombre) {
    // Encuentra el proyecto en la lista y actualiza su nombre
    final proyectoIndex = _proyectos.indexOf(proyecto);
    if (proyectoIndex != -1) {
      _proyectos[proyectoIndex] =
          proyecto.copyWith(nombreProyecto: nuevoNombre);
      notifyListeners();
    }
  }

  void addNuevoProyecto(String nuevoNombre, BuildContext context) async {
    // Crea una instancia de ProyectoCompanion con el nombre proporcionado.
    final proyectoCompanion = ProyectoCompanion.insert(
      nombreProyecto: nuevoNombre,
    );

    // Inserta la instancia en la base de datos Drift y obtén el ID generado automáticamente.
    final id = await Provider.of<AppDatabase>(context, listen: false)
        .into(Provider.of<AppDatabase>(context, listen: false).proyecto)
        .insert(proyectoCompanion);

    // Crea un nuevo proyecto con el ID generado y el nombre proporcionado.
    final nuevoProyecto =
        ProyectoData(idProyecto: id, nombreProyecto: nuevoNombre);

    // Agrega el nuevo proyecto a la lista de proyectos y notifica a los oyentes.
    _proyectos.add(nuevoProyecto);
    notifyListeners();
  }
}

class TareaModel extends ChangeNotifier {
  List<TareaData>? _tareas = [];
  List<TareaData>? _tareasNoCompletadas = [];
  List<TareaData>? _tareasCompletadas = [];

  TareaModel() {
    // Puedes inicializar las listas aquí si es necesario
    // Ejemplo:
    _tareas = <TareaData>[];
    _tareasNoCompletadas = <TareaData>[];
    _tareasCompletadas = <TareaData>[];
  }

  List<TareaData> get tareasNoCompletadas => _tareasNoCompletadas ?? [];
  List<TareaData> get tareasCompletadas => _tareasCompletadas ?? [];
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  Future<void> obtenerTareasDesdeBaseDeDatos(int idProyecto) async {
    try {
      final tareasNoCompletadas =
          await AppDatabase().getTareasNoCompletadas(idProyecto);
      final tareasCompletadas =
          await AppDatabase().getTareasCompletadas(idProyecto);

      _tareasNoCompletadas = tareasNoCompletadas;
      _tareasCompletadas = tareasCompletadas;

      notifyListeners();
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir al obtener las tareas desde la base de datos
      print('Error al obtener tareas desde la base de datos: $e');
    }
  }

  void setTareas(List<TareaData> tareasData) {
    _tareas = tareasData;
    _organizarTareasPorProyecto();
    notifyListeners();
  }

  List<TareaData> getTareasNoCompletadasPorProyecto(int idProyecto) {
    return _tareasNoCompletadas
            ?.where((tarea) => tarea.idProyecto == idProyecto)
            .toList() ??
        [];
  }

  List<TareaData> getTareasCompletadasPorProyecto(int idProyecto) {
    return _tareasCompletadas
            ?.where((tarea) => tarea.idProyecto == idProyecto)
            .toList() ??
        [];
  }

  void _organizarTareasPorProyecto() {
    _tareasNoCompletadas = [];
    _tareasCompletadas = [];

    for (var tarea in _tareas!) {
      if (tarea.completada) {
        _tareasCompletadas?.add(tarea);
      } else {
        _tareasNoCompletadas?.add(tarea);
      }
    }
  }

  void addTarea(TareaData tarea) {
    _tareas?.add(tarea);
    if (tarea.completada) {
      _tareasCompletadas?.add(tarea);
    } else {
      _tareasNoCompletadas?.add(tarea);
    }
    notifyListeners();
  }

  void removeTarea(TareaData tarea) {
    _tareas?.remove(tarea);
    if (tarea.completada) {
      _tareasCompletadas?.remove(tarea);
    } else {
      _tareasNoCompletadas?.remove(tarea);
    }
    notifyListeners();
  }

  void addNuevaTarea(int idProyectoN, String nuevaTareaNombre, int urgenciaN,
      String descripcionN, bool completadaN, BuildContext context) async {
    // Crea una instancia de TareaCompanion con el nombre proporcionado.
    final tareaCompanion = TareaCompanion.insert(
      idProyecto: idProyectoN,
      nombreTarea: nuevaTareaNombre,
      urgencia: urgenciaN,
      descripcion: descripcionN,
      completada: Value(completadaN),
    );
    // Inserta la instancia en la base de datos Drift y obtén el ID generado automáticamente.
    // ignore: unused_local_variable
    final id = await Provider.of<AppDatabase>(context, listen: false)
        .into(Provider.of<AppDatabase>(context, listen: false).tarea)
        .insert(tareaCompanion);

    // Actualiza directamente la lista desde la base de datos
    await obtenerTareasDesdeBaseDeDatos(idProyectoN);

    // Notifica a los oyentes
    notifyListeners();
  }

  Future<void> cambiarEstadoTarea(BuildContext context, TareaData tarea) async {
    try {
      // Actualiza el estado de la tarea en la base de datos
      await Provider.of<AppDatabase>(context, listen: false)
          .updateTarea(tarea.copyWith(completada: !tarea.completada));

      // Encuentra la tarea en la lista general y actualiza su estado
      final index = _tareas?.indexWhere((t) => t.idTarea == tarea.idTarea);
      if (index != null && index >= 0) {
        _tareas?[index] =
            _tareas![index].copyWith(completada: !tarea.completada);
      }

      // Refresca las listas de tareas completadas y no completadas
      _organizarTareasPorProyecto();

      // Notifica a los oyentes del modelo
      notifyListeners();

      print("Lista de tareas después del cambio de estado: $_tareas");
    } catch (e) {
      print('Error al cambiar el estado de la tarea: $e');
    }
  }
}
