// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
part 'drift_database.g.dart';

class HistorialPom extends Table {
  IntColumn get idP => integer().autoIncrement()();
  TextColumn get nombreSesionP => text().named('Sesión Pomodoro')();
  DateTimeColumn get fechaSesionP => dateTime().named('Fecha del Pomodoro')();
  DateTimeColumn get horaInicioP => dateTime().named('Hora de la sesión Pom')();
  DateTimeColumn get horaFinP => dateTime().named('Hora de finalización Pom')();
  IntColumn get pomodorosP => integer().named('Pomodoros hechos')();
  IntColumn get rondasP => integer().named('Rondas hechas')();
  TextColumn get tiempoSesionP =>
      text().named('Tiempo de las sesiones').withLength(max: 10)();
  TextColumn get anotacionesP => text().named('Anotaciones Pomodoro')();
}

class HistorialFlow extends Table {
  IntColumn get idF => integer().autoIncrement()();
  TextColumn get nombreSesionF => text().named('Sesión Flowtime')();
  DateTimeColumn get fechaSesionF => dateTime().named('Fecha del Flowtime')();
  DateTimeColumn get horaInicioF => dateTime().named('Hora del Flowtime')();
  DateTimeColumn get horaFinF =>
      dateTime().named('Hora de finalización Flow')();
  IntColumn get internas => integer().named('Interrupciones Internas')();
  IntColumn get externas => integer().named('Interrupciones Externas')();
  TextColumn get tiempoSesionF => text().named('Tiempo trabajado')();
  TextColumn get anotacionesF => text().named('Anotaciones Flowtime')();
}

class Proyecto extends Table {
  IntColumn get idProyecto => integer().autoIncrement()();
  TextColumn get nombreProyecto => text().customConstraint('NOT NULL')();
}

class Tarea extends Table {
  IntColumn get idTarea => integer().autoIncrement()();
  IntColumn get idProyecto => integer().references(Proyecto, #idProyecto)();
  TextColumn get nombreTarea => text()();
  IntColumn get urgencia => integer()();
  TextColumn get descripcion => text()();
  BoolColumn get completada => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [HistorialPom, HistorialFlow, Proyecto, Tarea])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onUpgrade: (migrator, from, to) async {
        if (from == 1) {
          // Realiza la migración desde la versión 1 a la versión 2
          migrator.addColumn(tarea, tarea.completada);
        }
      });
  //FUNCIONES POMODORO
  Future<List<HistorialPomData>> getRegistrosPList() async {
    return await select(historialPom).get();
  }

  Future<HistorialPomData> getRegistroP(int idP) async {
    return await (select(historialPom)..where((tbl) => tbl.idP.equals(idP)))
        .getSingle();
  }

  Future<int> insertRegistroP(HistorialPomCompanion item) async {
    return await into(historialPom).insert(item);
  }

  //FUNCIONES FLOWTIME
  Future<List<HistorialFlowData>> getRegistrosFList() async {
    return await select(historialFlow).get();
  }

  Future<HistorialFlowData> getRegistroF(int idF) async {
    return await (select(historialFlow)..where((tbl) => tbl.idF.equals(idF)))
        .getSingle();
  }

  Future<int> insertRegistroF(HistorialFlowCompanion item) async {
    return await into(historialFlow).insert(item);
  }

  //FUNCIONES PROYECTOS
  Future<List<ProyectoData>> getProyectos() async {
    return await select(proyecto).get();
  }

  Future<int> insertProyecto(ProyectoCompanion item) async {
    return await into(proyecto).insert(item);
  }

  Future<int> deleteProyecto(ProyectoData item) async {
    return await (delete(proyecto)
          ..where((tbl) => tbl.idProyecto.equals(item.idProyecto)))
        .go();
  }

  Future<List<ProyectoData>> getProyectosWithTareas() {
    return (select(proyecto)
          ..join(
            [
              leftOuterJoin(
                  tarea, tarea.idProyecto.equalsExp(proyecto.idProyecto)),
            ],
          ))
        .get();
  }

  //FUNCIONES TAREAS

  Future<List<TareaData>> getTareasNoCompletadas(int idProyecto) async {
    return await (select(tarea)
          ..where((t) =>
              t.idProyecto.equals(idProyecto) & t.completada.equals(false)))
        .get();
  }

  Future<List<TareaData>> getTareasCompletadas(int idProyecto) async {
    return await (select(tarea)
          ..where((t) =>
              t.idProyecto.equals(idProyecto) & t.completada.equals(true)))
        .get();
  }

  Future<List<TareaData>> getTareas(int idProyecto) async {
    return await (select(tarea)
          ..where((tbl) => tbl.idProyecto.equals(idProyecto)))
        .get();
  }

  Future<int> insertTarea(TareaCompanion item) async {
    return await into(tarea).insert(item);
  }

  Future<int> updateTarea(TareaData item) async {
    int result = await (update(tarea)
          ..where((tbl) => tbl.idTarea.equals(item.idTarea)))
        .write(TareaCompanion(completada: Value(item.completada)));
    print("Resultado de la actualización en la base de datos: $result");
    return result;
  }

  Future<TareaData> updateTareaYObtener(
      int idTarea, bool nuevoEstadoCompletado) async {
    print(
        "Actualizando tarea en DB - ID: $idTarea, Estado: $nuevoEstadoCompletado");
    var updateCount = await (update(tarea)
          ..where((t) => t.idTarea.equals(idTarea)))
        .write(TareaCompanion(completada: Value(nuevoEstadoCompletado)));
    print("Número de filas actualizadas: $updateCount");

    if (updateCount == 1) {
      var tareaActualizada = await (select(tarea)
            ..where((t) => t.idTarea.equals(idTarea)))
          .getSingle();
      print("Tarea actualizada en DB: $tareaActualizada");
      return tareaActualizada;
    } else {
      print("No se pudo actualizar la tarea en la DB");
      throw Exception("Error al actualizar la tarea");
    }
  }

  Future<TareaData?> getTareaById(int id) async {
    var resultado =
        await (select(tarea)..where((t) => t.idTarea.equals(id))).get();
    if (resultado.isNotEmpty) {
      print("Resultado de getTareaById: $resultado");
      return resultado.first;
    }
    return null;
  }

  Future<int> deleteTarea(TareaData item) async {
    return await (delete(tarea)
          ..where((tbl) => tbl.idTarea.equals(item.idTarea)))
        .go();
  }

  Future<List<TareaData>> getAllTareas() async {
    return await select(tarea).get();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tesisdb.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
