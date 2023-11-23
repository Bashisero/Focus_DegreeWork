// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis/drift_database.dart';
import 'dart:async';
import 'package:tesis/models.dart';
import 'package:tesis/detalleFlow.dart';

RegistroFlow ultFlow = RegistroFlow.empty();
DateTime hoy = 0 as DateTime;
String nombreFlowProv = '';
String tFlowProv = '';
DateTime fechaSesionProv = 0 as DateTime;
DateTime horaInicioProv = 0 as DateTime;
DateTime horaFinProv = 0 as DateTime;

class FlowTime extends StatefulWidget {
  final String? nombreSesion;
  final int? tareaId;
  final int? proyectoId;
  final int? urgencia;
  final String? descrip;
  const FlowTime(
      {super.key,
      this.nombreSesion,
      this.tareaId,
      this.proyectoId,
      this.urgencia,
      this.descrip});

  @override
  State<FlowTime> createState() => _FlowTimeState();
}

class _FlowTimeState extends State<FlowTime> with WidgetsBindingObserver {
  final TextEditingController _textFlowController = TextEditingController();
  bool blockTF = false;
  int intInternas = 0;
  int intExternas = 0;
  bool corriendoFl = false;
  Timer? timerFl;
  int segundosFl = 0;
  bool sesionIniciada = false;
  bool wasRunningBeforePause = false;
  bool esPrimeraVez = true;

  Future<void> addHistory(RegistroFlow reg) async {
    // Crea una instancia de HistorialPom y establece los valores de sus atributos.
    final nuevoRegistro = HistorialFlowCompanion.insert(
      nombreSesionF: reg.nombreF,
      fechaSesionF: reg.fechaF,
      horaInicioF: reg.inicSesionF,
      horaFinF: reg.finSesionF,
      internas: reg.internas,
      externas: reg.externas,
      tiempoSesionF: reg.tiempoSesionF,
      anotacionesF: reg.anotacionesF,
    );

    // Inserta la instancia en la base de datos Drift.
    await Provider.of<AppDatabase>(context, listen: false)
        .into(Provider.of<AppDatabase>(context, listen: false).historialFlow)
        .insert(nuevoRegistro);
  }

  String trabajadoAString(int segundos) {
    Duration duracion = Duration(seconds: segundos);

    int horas = duracion.inHours;
    int minutos = (duracion.inMinutes % 60);
    int segundosRestantes = (duracion.inSeconds % 60);

    String tiempoSesion =
        '${horas.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}:${segundosRestantes.toString().padLeft(2, '0')}';

    return tiempoSesion;
  }

  void bloquearNombre() {
    setState(() {
      blockTF = true;
    });
  }

  void iniciarCronoFl(int totalTimeInSeconds) {
    if (!corriendoFl) {
      corriendoFl = true;
      segundosFl = totalTimeInSeconds;
      timerFl = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          segundosFl++;
        });
        if (esPrimeraVez) {
          hoy = DateTime.now();
          horaInicioProv = DateTime(0, 0, 0, hoy.hour, hoy.minute, hoy.second);
          ultFlow.inicSesionF = horaInicioProv;
          esPrimeraVez =
              false; // Establecer a false después de la inicialización
        }
      });
    }
  }

  void detenerCronoFl() {
    if (corriendoFl) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Detener el cronómetro"),
                content: const Text(
                    "¿Está seguro? La sesión terminará con los datos recogidos hasta ahora"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancelar")),
                  TextButton(
                      onPressed: () async {
                        if (corriendoFl) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text(
                                      '¿Tiene alguna anotación acerca de esta sesión?'),
                                  title: const Text('Finalizar Sesión'),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.all(13),
                                      child: TextField(
                                          onChanged: (anotacion) {
                                            setState(() {
                                              ultFlow.anotacionesF = anotacion;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Anotaciones',
                                          )),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancelar"),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                setState(() {
                                                  detenerCronoFl();
                                                  ultFlow.internas =
                                                      intInternas;
                                                  ultFlow.externas =
                                                      intExternas;
                                                  corriendoFl = false;
                                                  timerFl?.cancel();
                                                });
                                                blockTF = false;
                                                ultFlow.nombreF =
                                                    nombreFlowProv;
                                                fechaSesionProv = DateTime(
                                                    hoy.year,
                                                    hoy.month,
                                                    hoy.day);
                                                ultFlow.fechaF =
                                                    fechaSesionProv;
                                                DateTime hoy2 = DateTime.now();
                                                horaFinProv = DateTime(
                                                    0,
                                                    0,
                                                    0,
                                                    hoy2.hour,
                                                    hoy2.minute,
                                                    hoy2.second);
                                                ultFlow.finSesionF =
                                                    horaFinProv;
                                                ultFlow.tiempoSesionF =
                                                    trabajadoAString(
                                                        segundosFl);
                                                if (ultFlow
                                                    .anotacionesF.isEmpty) {
                                                  ultFlow.anotacionesF =
                                                      "Ninguna";
                                                }
                                                addHistory(ultFlow);
                                                resetState();
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                if (widget.nombreSesion !=
                                                    null) {
                                                  _mostrarDialogoTareaCompletada(
                                                      context);
                                                }
                                              },
                                              child: const Text("Finalizar"))
                                        ]),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text("Detener"))
                ],
              );
            });
      });
    }
  }

  Stream<void> get onUpdate {
    return Stream.periodic(const Duration(seconds: 1));
  }

  String formaTiempoFl() {
    Duration duracion = Duration(seconds: segundosFl);

    String dosValores(int valor) {
      return valor < 10 ? "0$valor" : "$valor";
    }

    String horas = dosValores(duracion.inHours);
    String minutos = dosValores(duracion.inMinutes.remainder(60));
    String segundos = dosValores(duracion.inSeconds.remainder(60));

    return "$horas:$minutos:$segundos";
  }

  void resetState() {
    setState(() {
      intInternas = 0;
      intExternas = 0;
      segundosFl = 0;
      _textFlowController.clear();
      nombreFlowProv = _textFlowController.value.text;
      ultFlow = RegistroFlow.empty();
      sesionIniciada = false;
      esPrimeraVez = true;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.nombreSesion != null) {
      nombreFlowProv = widget.nombreSesion!;
      _textFlowController.text = widget.nombreSesion!;
      setState(() {
        blockTF = true;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timerFl?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      wasRunningBeforePause = corriendoFl;
      if (corriendoFl) {
        corriendoFl = false;
        timerFl?.cancel();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (wasRunningBeforePause) {
        iniciarCronoFl(segundosFl); // Reanuda solo si estaba corriendo antes
        wasRunningBeforePause = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flowtime",
              style: TextStyle(color: Color(0xFFFAF5F1))),
          backgroundColor: Theme.of(context).colorScheme.primary,
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.air, color: Color(0xFFFAF5F1)),
                child: DefaultTextStyle(
                    style: TextStyle(color: Color(0xFFFAF5F1)),
                    child: Text("Iniciar")),
              ),
              Tab(
                icon: Icon(Icons.list_alt_rounded, color: Color(0xFFFAF5F1)),
                child: DefaultTextStyle(
                    style: TextStyle(color: Color(0xFFFAF5F1)),
                    child: Text("Historial")),
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset('assets/vientoIcon.png'),
                  ),
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: Stack(children: [
                      TextField(
                        enabled: !blockTF,
                        onChanged: (value) {
                          setState(() {
                            nombreFlowProv = value;
                          });
                        },
                        controller: _textFlowController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '¿Qué desea realizar?',
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StreamBuilder<void>(
                      stream: onUpdate,
                      builder: (context, snapshot) {
                        return Text(formaTiempoFl(),
                            style: const TextStyle(
                                fontSize: 60, color: Colors.black54));
                      },
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          iconSize: 58,
                          onPressed: () {
                            if (corriendoFl) {
                              detenerCronoFl();
                            } else {
                              if (_textFlowController.value.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Ingresa un nombre de sesión'),
                                    backgroundColor: Color(0xFF356D64),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                iniciarCronoFl(0);
                                sesionIniciada = true;
                                blockTF = true;
                              }
                            }
                          },
                          icon: corriendoFl
                              ? const Icon(Icons.pause_circle_rounded)
                              : const Icon(Icons.play_circle_rounded),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 15, 182, 182),
                                shape: BoxShape.circle),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: corriendoFl
                                  ? () {
                                      intInternas++;
                                      setState(() {});
                                    }
                                  : null,
                              icon: const Icon(Icons.sensor_occupied_rounded),
                            ),
                          ),
                          const Text("Interrupción interna"),
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  child: Center(
                                      child: Text(
                                    intInternas.toString(),
                                    style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 15, 182, 182),
                                shape: BoxShape.circle),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: corriendoFl
                                  ? () {
                                      intExternas++;
                                      setState(() {});
                                    }
                                  : null,
                              icon: const Icon(Icons.spatial_audio_rounded),
                            ),
                          ),
                          const Text("Interrupción externa"),
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  child: Center(
                                      child: Text(intExternas.toString(),
                                          style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                          )))),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: []),
                ],
              );
            },
          ),
          FutureBuilder<List<HistorialFlowData>>(
            future: Provider.of<AppDatabase>(context).getRegistrosFList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final registros = snapshot.data;
                if (registros == null || registros.isEmpty) {
                  return const Center(
                      child: Text(
                    'Aún no hay registros',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                    ),
                  ));
                } else {
                  return ListView.builder(
                    reverse: true,
                    itemCount: registros.length,
                    itemBuilder: (context, index) {
                      final registro = registros[index];
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetalleFlow(registro: registro)));
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 15, 182, 182),
                                    borderRadius: BorderRadius.circular(12.5),
                                  ),
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      registro.nombreSesionF,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0,
                                              right: 8.0,
                                              bottom: 8.0),
                                          child: Text(DateFormat('dd/MM/yyyy')
                                              .format(registro.fechaSesionF)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 40.0,
                                              right: 8.0,
                                              bottom: 8.0),
                                          child: Text(DateFormat('HH:mm')
                                              .format(registro.horaInicioF)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "Trabajaste por: ${registro.tiempoSesionF}"),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${registro.internas + registro.externas}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const Icon(
                                              Icons.warning_amber_rounded,
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                }
              }
            },
          )
        ]),
      ),
    );
  }

  Future<void> pruebaDirectaActualizacionTarea(int idTarea) async {
    var db = Provider.of<AppDatabase>(context, listen: false);
    await db.updateTarea(TareaData(
      idTarea: idTarea,
      nombreTarea: widget.nombreSesion!,
      completada: true,
      idProyecto: widget.proyectoId!,
      urgencia: widget.urgencia!,
      descripcion: widget.descrip!,
    ));
    // ignore: unused_local_variable
    var tareaActualizada = await db.getTareaById(idTarea);
  }

  void _mostrarDialogoTareaCompletada(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tarea Completada'),
          content: Text('¿Completaste la tarea "${widget.nombreSesion}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await pruebaDirectaActualizacionTarea(widget.tareaId!);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }
}
