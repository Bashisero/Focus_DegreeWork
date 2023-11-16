// ignore_for_file: file_names, avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/drift_database.dart';
import 'package:tesis/models.dart';
import 'package:tesis/pomodoro.dart';

class DetallesProyecto extends StatefulWidget {
  final ProyectoData proyecto;
  const DetallesProyecto({super.key, required this.proyecto});

  @override
  State<DetallesProyecto> createState() => _DetallesProyectoState();
}

class _DetallesProyectoState extends State<DetallesProyecto> {
  @override
  void initState() {
    super.initState();
    Provider.of<TareaModel>(context, listen: false)
        .obtenerTareasDesdeBaseDeDatos(widget.proyecto.idProyecto,
            Provider.of<AppDatabase>(context, listen: false));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.proyecto.nombreProyecto),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "TO DO",
              ),
              Tab(
                text: "DONE",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Consumer<TareaModel>(
              builder: (context, tareaModel, child) {
                final tareasNoCompletadas =
                    tareaModel.getTareasNoCompletadasPorProyecto(
                        widget.proyecto.idProyecto);
                if (tareasNoCompletadas.isEmpty) {
                  return const Center(
                    child: Text('No hay tareas por hacer.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: tareasNoCompletadas.length,
                    itemBuilder: (context, index) {
                      final tarea = tareasNoCompletadas[index];
                      return TareaCard(tarea: tarea, idProyecto: widget.proyecto.idProyecto,);
                    },
                  );
                }
              },
            ),
            Consumer<TareaModel>(
              builder: (context, tareaModel, child) {
                final tareasCompletadas =
                    tareaModel.getTareasCompletadasPorProyecto(
                        widget.proyecto.idProyecto);
                if (tareasCompletadas.isEmpty) {
                  return const Center(
                    child: Text('No hay tareas hechas.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: tareasCompletadas.length,
                    itemBuilder: (context, index) {
                      final tarea = tareasCompletadas[index];
                      return TareaCard(tarea: tarea, idProyecto: widget.proyecto.idProyecto,);
                    },
                  );
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return TareaDialog(proyecto: widget.proyecto);
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TareaCard extends StatelessWidget {
  final TareaData tarea;
  final int idProyecto;
  const TareaCard({super.key, required this.tarea, required this.idProyecto});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(tarea.nombreTarea),
        subtitle: Text(tarea.descripcion),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              onPressed: () {
                print(
                    "Enviando a Pomodoro - Tarea ID: ${tarea.idTarea}, Nombre: ${tarea.nombreTarea}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Pomodoro(
                            nombreSesion: tarea.nombreTarea,
                            tareaId: tarea.idTarea,
                            proyectoId: tarea.idProyecto,
                            urgencia: tarea.urgencia,
                            descrip: tarea.descripcion))).then((_) {
                  Provider.of<TareaModel>(context, listen: false)
                      .obtenerTareasDesdeBaseDeDatos(idProyecto,
                          Provider.of<AppDatabase>(context, listen: false));
                });
              },
              icon: const Icon(Icons.play_circle)),
          IconButton(
              onPressed: () {
                _mostrarDialogoConfirmacion(context, tarea);
              },
              icon: const Icon(Icons.check)),
          IconButton(
            onPressed: () {
              _mostrarDialogoEliminar(context, tarea);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          )
        ]),
      ),
    );
  }

  Future<void> _mostrarDialogoConfirmacion(
      BuildContext context, TareaData tarea) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: const Text("¿Marcar tarea como completada?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                print(
                    'Estado de la tarea antes del cambio de estado: ${tarea.completada}');
                await Provider.of<TareaModel>(context, listen: false)
                    .cambiarEstadoTarea(context, tarea);
                TareaData? tareaActualizada =
                    // ignore: use_build_context_synchronously
                    await Provider.of<TareaModel>(context, listen: false)
                        .getTareaPorId(context, tarea.idTarea);
                print(
                    "Estado de la tarea después del cambio: ${tareaActualizada?.completada}");
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _mostrarDialogoEliminar(
      BuildContext context, TareaData tarea) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Eliminar Tarea'),
          content: Text(
              '¿Estás seguro de que quieres eliminar "${tarea.nombreTarea}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Aquí iría la lógica para eliminar la tarea de la base de datos
                await Provider.of<TareaModel>(context, listen: false)
                    .borrarTarea(context, tarea);
                // ignore: use_build_context_synchronously
                Navigator.of(dialogContext)
                    .pop(); // Cerrar el diálogo después de eliminar
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}

class TareaDialog extends StatefulWidget {
  final ProyectoData proyecto;
  const TareaDialog({Key? key, required this.proyecto}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TareaDialogState createState() => _TareaDialogState();
}

class _TareaDialogState extends State<TareaDialog> {
  final TextEditingController nombreController = TextEditingController();
  int prioridad = 1; // 1: Baja, 2: Normal, 3: Alta
  final TextEditingController anotacionesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Crear Tarea"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: nombreController,
              onChanged: (nombre) {},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre de la Tarea',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Prioridad: "),
              DropdownButton<int>(
                value: prioridad,
                onChanged: (value) {
                  setState(() {
                    prioridad = value!;
                  });
                },
                items: const [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Baja'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('Normal'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('Alta'),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextField(
              controller: anotacionesController,
              onChanged: (anotaciones) {},
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Anotaciones de la Tarea (Opcional)',
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (nombreController.text == "" || nombreController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Asígnale un nombre a la tarea'),
                ),
              );
            } else {
              // Utiliza la función addNuevaTarea para agregar la tarea a la base de datos
              Provider.of<TareaModel>(context, listen: false).addNuevaTarea(
                widget.proyecto.idProyecto,
                nombreController.text,
                prioridad,
                anotacionesController.text,
                context,
              );

              Navigator.pop(context);
            }
          },
          child: const Text("Crear"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancelar"),
        ),
      ],
    );
  }
}
