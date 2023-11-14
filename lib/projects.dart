import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:tesis/detallesProyecto.dart';
import 'package:tesis/drift_database.dart';
import 'package:tesis/models.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  // ignore: unused_field
  late Future<List<ProyectoData>> _futureProyectos;
  String nombreProy = "";

  Future<void> addProy(String nombre) async {
    // Crea una instancia de HistorialPom y establece los valores de sus atributos.
    final nuevoProyecto = ProyectoCompanion.insert(
      nombreProyecto: nombre,
    );

    // Inserta la instancia en la base de datos Drift.
    await Provider.of<AppDatabase>(context, listen: false)
        .into(Provider.of<AppDatabase>(context, listen: false).proyecto)
        .insert(nuevoProyecto);
  }

  Future<void> _loadProyectos() async {
    final proyectos =
        await Provider.of<AppDatabase>(context, listen: false).getProyectos();
    // ignore: use_build_context_synchronously
    final proyectoModel = Provider.of<ProyectoModel>(context, listen: false);
    proyectoModel.setProyectos(proyectos);
    setState(() {}); // Añade setState para notificar a la interfaz de usuario
  }

  @override
  void initState() {
    super.initState();
    _futureProyectos =
        Provider.of<AppDatabase>(context, listen: false).getProyectos();
    _loadProyectos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _futureProyectos = Provider.of<AppDatabase>(context).getProyectos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyectos'),
      ),
      body: Consumer<ProyectoModel>(
        builder: (context, proyectoModel, child) {
          final proyectosData = proyectoModel.proyectos;
          if (proyectosData.isEmpty) {
            return const Center(
              child: Text(
                  'No tienes ningún proyecto, empieza con el botón de abajo'),
            );
          } else {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: proyectosData.length,
              itemBuilder: (context, index) {
                final proyectoData = proyectosData[index];
                return ProyectoCard(
                  proyecto: proyectoData,
                  onDelete: () async {
                    final proyectoModel = Provider.of<ProyectoModel>(context, listen: false);
                    await Provider.of<AppDatabase>(context, listen: false).deleteProyecto(proyectoData);
                    proyectoModel.removeProyecto(proyectoData); // Implementa la lógica para eliminar el proyecto
                  },
                );
              },
              staggeredTileBuilder: (int index) =>
                  const StaggeredTile.extent(1, 150),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Crear nuevo proyecto'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: TextField(
                      onChanged: (nombre) {
                        nombreProy = nombre;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre del Proyecto',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          ProyectoModel proyectoModel =
                              Provider.of<ProyectoModel>(context,
                                  listen: false);
                          proyectoModel.addNuevoProyecto(nombreProy, context);
                          Navigator.pop(context);
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
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProyectoCard extends StatelessWidget {
  final ProyectoData proyecto;
  final VoidCallback onDelete;

  const ProyectoCard(
      {super.key, required this.proyecto, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context)=> DetallesProyecto(proyecto: proyecto)), 
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            ListTile(
              title: Text(proyecto.nombreProyecto),
              // Más widgets y diseño aquí
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
