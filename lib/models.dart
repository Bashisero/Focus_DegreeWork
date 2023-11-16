// ignore_for_file: avoid_print, use_build_context_synchronously
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
  List<TareaData> _tareas = [];
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

  Future<void> obtenerTareasDesdeBaseDeDatos(
      int idProyecto, AppDatabase db) async {
    try {
      final tareasNoCompletadas = await db.getTareasNoCompletadas(idProyecto);
      final tareasCompletadas = await db.getTareasCompletadas(idProyecto);

      _tareas = [...tareasNoCompletadas, ...tareasCompletadas];
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
    _tareasNoCompletadas = _tareas.where((tarea) => !tarea.completada).toList();
    _tareasCompletadas = _tareas.where((tarea) => tarea.completada).toList();
  }

  void addTarea(TareaData tarea) {
    _tareas.add(tarea);
    if (tarea.completada) {
      _tareasCompletadas?.add(tarea);
    } else {
      _tareasNoCompletadas?.add(tarea);
    }
    notifyListeners();
  }

  void removeTarea(TareaData tarea) {
    _tareas.remove(tarea);
    if (tarea.completada) {
      _tareasCompletadas?.remove(tarea);
    } else {
      _tareasNoCompletadas?.remove(tarea);
    }
    notifyListeners();
  }

  void addNuevaTarea(int idProyectoN, String nuevaTareaNombre, int urgenciaN,
      String descripcionN, BuildContext context) async {
    final tareaCompanion = TareaCompanion.insert(
      idProyecto: idProyectoN,
      nombreTarea: nuevaTareaNombre,
      urgencia: urgenciaN,
      descripcion: descripcionN,
      completada: const Value(
          false), // Asegúrate de que la tarea se crea como no completada
    );
    // ignore: unused_local_variable
    final id = await Provider.of<AppDatabase>(context, listen: false)
        .into(Provider.of<AppDatabase>(context, listen: false).tarea)
        .insert(tareaCompanion);
    await obtenerTareasDesdeBaseDeDatos(
        idProyectoN, Provider.of<AppDatabase>(context, listen: false));
    notifyListeners();
  }

  Future<void> cambiarEstadoTarea(BuildContext context, TareaData tarea) async {
    try {
      print("cambiarEstadoTarea - Tarea antes de la actualización: $tarea");
      TareaData tareaActualizada =
          await Provider.of<AppDatabase>(context, listen: false)
              .updateTareaYObtener(tarea.idTarea, !tarea.completada);
      print(
          "updateTareaYObtener - Tarea después de la actualización: $tareaActualizada");

      int index = _tareas.indexWhere((t) => t.idTarea == tarea.idTarea);
      if (index != -1) {
        _tareas[index] = tareaActualizada;
      } else {
        _tareas.add(tareaActualizada);
      }
      _organizarTareasPorEstado();
      print("Lista de tareas actualizada en TareaModel");

      notifyListeners();
    } catch (e) {
      print('Error al cambiar el estado de la tarea: $e');
    }
  }

  Future<void> borrarTarea(BuildContext context, TareaData tarea) async {
    try {
      // Llama a la función deleteTarea de tu clase de base de datos.
      await Provider.of<AppDatabase>(context, listen: false).deleteTarea(tarea);

      // Actualiza directamente la lista desde la base de datos
      await obtenerTareasDesdeBaseDeDatos(
          tarea.idProyecto, Provider.of<AppDatabase>(context, listen: false));
    } catch (e) {
      // Aquí podrías manejar cualquier excepción que se produzca en el proceso de eliminación.
      print('Error al eliminar la tarea: $e');
    }
  }

  // Este método obtiene una tarea específica por su ID.
  Future<TareaData?> getTareaPorId(BuildContext context, int id) async {
    return await Provider.of<AppDatabase>(context, listen: false)
        .getTareaById(id);
  }

  void _organizarTareasPorEstado() {
    _tareasNoCompletadas = _tareas.where((t) => !t.completada).toList();
    _tareasCompletadas = _tareas.where((t) => t.completada).toList();
  }
}
