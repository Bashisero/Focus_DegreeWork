// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:flutter/material.dart';
import 'package:tesis/descansoPom.dart';
import 'package:tesis/detalleRegistro.dart';
import 'package:tesis/drift_database.dart';
import 'package:tesis/models.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

const List<String> list = <String>["05:00", "10:00", "15:00", "20:00", "25:00"];
String tSesionProv = "";
String nombreSesionProv = "";
RegistroPom ultRegistro = RegistroPom.empty();
DateTime fechaSesionProv = 0 as DateTime;
DateTime horaInicioProv = 0 as DateTime;
DateTime horaFinProv = 0 as DateTime;
DateTime hoy = 0 as DateTime;

class Pomodoro extends StatefulWidget {
  final String? nombreSesion;
  final int? tareaId;
  final int? proyectoId;
  final int? urgencia;
  final String? descrip;

  const Pomodoro(
      {Key? key,
      this.nombreSesion,
      this.tareaId,
      this.proyectoId,
      this.urgencia,
      this.descrip})
      : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> with WidgetsBindingObserver {
  String selectedTime = "05:00";
  bool bloquearDropdown = false;
  bool cronoVisible = false;
  bool bloquearTextField = false;
  int segundos = 0;
  bool corriendo = false;
  bool sesionIniciada = false;
  late Timer timer;
  final StreamController<int> _tomatesStreamController =
      StreamController<int>.broadcast();
  final TextEditingController _textFieldController = TextEditingController();
  final player = AudioPlayer();
  int tomates = 0;
  int rondas = 0;
  bool sesionYaIniciada = false; // Nueva variable para llevar registro

  Future<void> addHistory(RegistroPom reg) async {
    final nuevoRegistro = HistorialPomCompanion.insert(
      nombreSesionP: reg.nombreSesionP,
      fechaSesionP: reg.fechaP,
      horaInicioP: reg.inicSesionP,
      horaFinP: reg.finSesionP,
      pomodorosP: reg.pomodorosP,
      rondasP: reg.numRondasP,
      tiempoSesionP: reg.tiempoSesionP,
      anotacionesP: reg.anotacionesP,
    );
    await Provider.of<AppDatabase>(context, listen: false)
        .into(Provider.of<AppDatabase>(context, listen: false).historialPom)
        .insert(nuevoRegistro);
  }

  void iniciarCrono(int totalTimeInSeconds) {
    if (!corriendo) {
      sesionIniciada = true;
      corriendo = true;
      segundos = totalTimeInSeconds;
      if (!sesionYaIniciada) {
        hoy = DateTime.now(); // Solo se inicializa la primera vez
        horaInicioProv = DateTime(0, 0, 0, hoy.hour, hoy.minute, hoy.second);
        ultRegistro.inicSesionP = horaInicioProv;
        sesionYaIniciada = true; // Marcamos que la sesión ya ha iniciado
      }
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        segundos--;
        if (segundos == 0) {
          detenerCrono();
          player.setReleaseMode(ReleaseMode.loop);
          player.play(AssetSource('piano.mp3'));
          tomates++;
          _tomatesStreamController.add(tomates);
          if (tomates == 4) {
            rondas++;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("¡Has terminado una ronda!"),
                  content: const Text(
                    "Finalizaste una ronda de 4 Pomodoros, te has ganado un descanso de 20 minutos",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          corriendo = false;
                        });
                        Navigator.pop(context);
                        player.stop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DescansoPom(
                                    tomates: tomates,
                                    rondas: rondas))).then((returnedTomates) {
                          if (returnedTomates == 4) {
                            setState(() {
                              tomates = 0;
                            });
                          }
                        });
                      },
                      child: const Text("Continuar"),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("¡Has terminado una sesión!"),
                  content: const Text(
                    "Has terminado un pomodoro, aquí tienes 5 minutos de descanso",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          corriendo = false;
                        });
                        Navigator.pop(context);
                        player.stop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DescansoPom(
                                    tomates: tomates,
                                    rondas: rondas))).then((returnedTomates) {
                          if (returnedTomates == 4) {
                            setState(() {
                              tomates = 0;
                            });
                          }
                        });
                      },
                      child: const Text("Continuar"),
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    } else {
      detenerCrono();
    }
  }

  void detenerCrono() {
    if (corriendo) {
      corriendo = false;
      timer.cancel();
    }
  }

  Stream<void> get onUpdate {
    return Stream.periodic(const Duration(seconds: 1));
  }

  String formaTiempo() {
    Duration duracion = Duration(seconds: this.segundos);

    String dosValores(int valor) {
      return valor < 10 ? "0$valor" : "$valor";
    }

    String horas = dosValores(duracion.inHours);
    String minutos = dosValores(duracion.inMinutes.remainder(60));
    String segundos = dosValores(duracion.inSeconds.remainder(60));

    return "$horas:$minutos:$segundos";
  }

  int dateToTimeStamp(DateTime date) {
    return date.millisecondsSinceEpoch;
  }

  DateTime timeStampToDate(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  void bloquearNombre() {
    setState(() {
      bloquearTextField = true;
    });
  }

  void resetState() {
    setState(() {
      detenerCrono();
      tomates = 0;
      rondas = 0;
      cronoVisible = false;
      _textFieldController.clear();
      nombreSesionProv = _textFieldController.value.text;
      ultRegistro = RegistroPom.empty();
      sesionIniciada = false;
      bloquearTextField = false;
    });
  }

  Color obtenerColorDropdown(bool ver, BuildContext context) {
    if (!ver) {
      return Colors.black;
    } else {
      return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.nombreSesion != null) {
      nombreSesionProv = widget.nombreSesion!;
      _textFieldController.text = widget.nombreSesion!;
      bloquearNombre();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    detenerCrono();
    player.stop();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Asegurarse de que el cronómetro se reinicie solo si la sesión estaba en curso
    if (state == AppLifecycleState.paused && corriendo) {
      detenerCrono();
    } else if (state == AppLifecycleState.resumed && sesionIniciada && !corriendo && segundos > 0) {
      iniciarCrono(segundos);
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (sesionIniciada) {
          final confirmSalir = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('¿Interrumpir la sesión?'),
                content: const Text(
                    'Perderás el progreso de toda la sesión si lo haces'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Continuar sesión"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Salir"),
                  ),
                ],
              );
            },
          );
          if (confirmSalir == true) {
            setState(() {
              detenerCrono();
              cronoVisible = false;
              bloquearDropdown = false;
              if (widget.nombreSesion == null) {
                bloquearTextField = false;
              }
            });
            return true;
          }
          return false;
        }
        return true;
      },
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Pomodoro",
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
                    icon: Icon(Icons.fitness_center, color: Color(0xFFFAF5F1)),
                    child: DefaultTextStyle(
                      style: TextStyle(color: Color(0xFFFAF5F1)),
                      child: Text("Iniciar"),
                    )),
                Tab(
                    icon:
                        Icon(Icons.list_alt_rounded, color: Color(0xFFFAF5F1)),
                    child: DefaultTextStyle(
                      style: TextStyle(color: Color(0xFFFAF5F1)),
                      child: Text("Historial"),
                    )),
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
                      child: Image.asset('assets/tomateCopia.png'),
                    ),
                    SizedBox(
                      width: 250,
                      height: 70,
                      child: Stack(
                        children: [
                          TextField(
                            enabled: !bloquearTextField,
                            onChanged: (value) {
                              setState(() {
                                nombreSesionProv = value;
                              });
                            },
                            controller: _textFieldController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '¿Qué desea realizar?',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Visibility(
                        visible: cronoVisible,
                        child: StreamBuilder<void>(
                          stream: onUpdate,
                          builder: (context, snapshot) {
                            return Text(formaTiempo(),
                                style: const TextStyle(
                                    fontSize: 60, color: Colors.black54));
                          },
                        ),
                      ),
                    ),
                    Text("Rondas: $rondas",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: bloquearDropdown
                              ? null
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Elige tu tiempo de cada Pomodoro',
                                            textAlign: TextAlign.center),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children:
                                              list.asMap().entries.map((entry) {
                                            int idx = entry.key;
                                            String value = entry.value;

                                            return Column(
                                              children: <Widget>[
                                                ListTile(
                                                  title: Text(value),
                                                  onTap: () {
                                                    setState(() {
                                                      selectedTime = value;
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                ),
                                                if (idx != list.length - 1)
                                                  const Divider(),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  );
                                },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                selectedTime,
                                style: TextStyle(
                                  color: obtenerColorDropdown(
                                      bloquearDropdown, context),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: corriendo == false
                                ? () {
                                    if (nombreSesionProv.isNotEmpty) {
                                      final timeParts = selectedTime.split(':');
                                      final minutes = int.parse(timeParts[0]);
                                      final seconds = int.parse(timeParts[1]);
                                      final totalTimeInSeconds =
                                          (minutes * 60) + seconds;
                                      setState(() {
                                        iniciarCrono(totalTimeInSeconds);
                                        cronoVisible = true;
                                        bloquearDropdown = true;
                                      });
                                      bloquearNombre();
                                      sesionIniciada = true;
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text('Ingresa un nombre de sesión'),
                                        backgroundColor: Color(0xFF356D64),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  }
                                : null,
                            child: const Text("Iniciar"),
                          ),
                          ElevatedButton(
                              onPressed: sesionIniciada && corriendo
                                  ? () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  '¿Terminar la sesión?'),
                                              content: const Text(
                                                  'Perderás el progreso de este pomodoro si lo haces'),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                        "Continuar sesión")),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      detenerCrono();
                                                    });
                                                    Navigator.pop(
                                                        context, 'Detener');
                                                    cronoVisible =
                                                        !cronoVisible;
                                                    bloquearDropdown = false;
                                                    if (widget.nombreSesion ==
                                                        null) {
                                                      bloquearTextField = false;
                                                    }
                                                  },
                                                  child: const Text("Detener"),
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  : null,
                              child: const Text("Detener")),
                        ]),
                    Center(
                      child: ElevatedButton(
                          onPressed: sesionIniciada &&
                                  corriendo == false &&
                                  (tomates > 0 || rondas > 0)
                              ? () async {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return AlertDialog(
                                            content: const Text(
                                                '¿Tiene alguna anotación acerca de esta sesión?'),
                                            title:
                                                const Text('Finalizar Sesión'),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(13),
                                                child: TextField(
                                                    onChanged: (anotacion) {
                                                      setState(() {
                                                        ultRegistro
                                                                .anotacionesP =
                                                            anotacion;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Anotaciones',
                                                    )),
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          "Cancelar"),
                                                    ),
                                                    TextButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            detenerCrono();
                                                            ultRegistro
                                                                    .pomodorosP =
                                                                (rondas * 4) +
                                                                    tomates;
                                                            ultRegistro
                                                                    .numRondasP =
                                                                rondas;
                                                          });
                                                          bloquearDropdown =
                                                              false;
                                                          bloquearTextField =
                                                              false;
                                                          cronoVisible =
                                                              !cronoVisible;
                                                          tSesionProv =
                                                              selectedTime;
                                                          //////
                                                          ultRegistro
                                                                  .nombreSesionP =
                                                              nombreSesionProv;
                                                          ultRegistro
                                                                  .tiempoSesionP =
                                                              tSesionProv;
                                                          fechaSesionProv =
                                                              DateTime(
                                                                  hoy.year,
                                                                  hoy.month,
                                                                  hoy.day);
                                                          ultRegistro.fechaP =
                                                              fechaSesionProv;
                                                          DateTime hoy2 =
                                                              DateTime.now();
                                                          horaFinProv =
                                                              DateTime(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  hoy2.hour,
                                                                  hoy2.minute,
                                                                  hoy2.second);
                                                          ultRegistro
                                                                  .finSesionP =
                                                              horaFinProv;
                                                          rondas = 0;
                                                          if (ultRegistro
                                                              .anotacionesP
                                                              .isEmpty) {
                                                            ultRegistro
                                                                    .anotacionesP =
                                                                "Sin comentarios";
                                                          }
                                                          addHistory(
                                                              ultRegistro);
                                                          resetState();
                                                          Navigator.of(context)
                                                              .pop();
                                                          if (widget
                                                                  .nombreSesion !=
                                                              null) {
                                                            _mostrarDialogoTareaCompletada(
                                                                context);
                                                          }
                                                        },
                                                        child: const Text(
                                                            "Finalizar"))
                                                  ]),
                                            ]);
                                      });
                                }
                              : null,
                          child: const Text("Guardar y Terminar")),
                    ),
                    StreamBuilder<Object>(
                        stream: _tomatesStreamController.stream,
                        initialData: tomates,
                        builder: (context, snapshot) {
                          return Card(
                              margin: const EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: SizedBox(
                                height: 100.0,
                                width: 260.0,
                                child: StreamBuilder<Object>(
                                    stream: _tomatesStreamController.stream,
                                    initialData: tomates,
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                          itemCount: 4,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            bool activado = index < tomates;
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  activado
                                                      ? 'assets/tomateIcon.png'
                                                      : 'assets/dark_tomateIcon.png',
                                                  width: 50,
                                                  height: 50,
                                                ));
                                          });
                                    }),
                              ));
                        }),
                    Center(
                      child: Text(
                          "Pomodoros totales: ${(rondas * 4) + tomates}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                );
              },
            ),
            FutureBuilder<List<HistorialPomData>>(
              future: Provider.of<AppDatabase>(context).getRegistrosPList(),
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
                                          DetalleRegistro(registro: registro)));
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD37A)
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(12.5),
                                    ),
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        registro.nombreSesionP,
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
                                                .format(registro.fechaSesionP)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 40.0,
                                                right: 8.0,
                                                bottom: 8.0),
                                            child: Text(DateFormat('HH:mm')
                                                .format(registro.horaInicioP)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Rondas de: ${registro.tiempoSesionP}"),
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
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "${registro.pomodorosP}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Image.asset(
                                                  'assets/tomateIcon.png',
                                                  height: 35,
                                                  width: 35),
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
      ),
    );
  }

  Future<void> pruebaDirectaActualizacionTarea(int idTarea) async {
    var db = Provider.of<AppDatabase>(context, listen: false);

    // Actualiza la tarea directamente en la base de datos
    await db.updateTarea(TareaData(
      idTarea: idTarea,
      nombreTarea: widget.nombreSesion!,
      completada: true,
      idProyecto: widget.proyectoId!,
      urgencia: widget.urgencia!,
      descripcion: widget.descrip!,
      // Asegúrate de incluir todos los otros campos necesarios aquí
    ));

    // Recupera la tarea actualizada para verificar
    var tareaActualizada = await db.getTareaById(idTarea);
  }

  void _mostrarDialogoTareaCompletada(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
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
