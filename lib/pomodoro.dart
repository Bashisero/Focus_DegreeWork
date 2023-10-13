import 'package:flutter/material.dart';
import 'package:tesis/descansoPom.dart';
import 'package:tesis/focusdb.dart';
import 'package:tesis/models.dart';
import 'package:tesis/resultados.dart';
import 'dart:async';
import 'main.dart';

const List<String> list = <String>["00:05", "00:10", "20:00", "25:00", "30:00"];
String tSesionProv = "";
String nombreSesionProv = "";
RegistroPom ultRegistro = RegistroPom.empty();
DateTime fechaSesionProv = 0 as DateTime;
DateTime horaInicioProv = 0 as DateTime;
DateTime horaFinProv = 0 as DateTime;
DateTime hoy = DateTime.now();
/*class _RegistroSesion extends StatelessWidget {
  final RegistroPom registroP;

  _RegistroSesion(this.registroP);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(children: [Text(registroP.nombreP)])
    ]);
  }
}*/
Future<void> addHistory(RegistroPom registro) async {
  final item = RegistroPom(
      nombreSesionP: registro.nombreSesionP,
      fechaP: registro.fechaP,
      inicSesionP: registro.inicSesionP,
      finSesionP: registro.finSesionP,
      pomodorosP: registro.pomodorosP,
      numRondasP: registro.numRondasP,
      tiempoSesionP: registro.tiempoSesionP,
      anotacionesP: registro.anotacionesP);
  /*print("nombreSesionP: ${item.nombreSesionP}");
  print("fechaP: ${item.fechaP}");
  print("inicSesionP: ${item.inicSesionP}");
  print("finSesionP: ${item.finSesionP}");
  print("pomodorosP: ${item.pomodorosP}");
  print("numRondasP: ${item.numRondasP}");
  print("tiempoSesionP: ${item.tiempoSesionP}");
  print("anotacionesP: ${item.anotacionesP}");*/
  await FocusDB.instance.insertHistPom(item);
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  String selectedTime = "00:05";
  bool bloquearDropdown = false;
  bool cronoVisible = false;
  bool bloquearTextField = false;
  int segundos = 0;
  bool corriendo = false;
  bool sesionTerminada = false;
  late Timer timer;
  final StreamController<int> _tomatesStreamController =
      StreamController<int>.broadcast();

  void iniciarCrono(int totalTimeInSeconds) {
    if (!corriendo) {
      corriendo = true;
      segundos = totalTimeInSeconds;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        segundos--;
        if (segundos == 0) {
          detenerCrono(); // Detener el temporizador
          tomates++;
          _tomatesStreamController.add(tomates);
          if (tomates == 4) {
            tomates = 0; // Reiniciar el contador de tomates
            rondas++;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("¡Has terminado una ronda!"),
                  content: const Text(
                    "Finalizaste una ronda de 4 Pomodoros, te has ganado un descanso de 20 minutos",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/descansoPom',
                        );
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
              builder: (context) {
                return AlertDialog(
                  title: const Text("¡Has terminado una sesión!"),
                  content: const Text(
                    "Has terminado un pomodoro, aquí tienes 5 minutos de descanso",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/descansoPom');
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

  void bloquearNombre() {
    setState(() {
      bloquearTextField = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    detenerCrono();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pomodoro"),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.fitness_center),
                text: "Iniciar",
              ),
              Tab(
                icon: Icon(Icons.list_alt_rounded),
                text: "Historial",
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
                    child: Image.asset('assets/tomateCopia.png'),
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: Stack(
                      children: [
                        TextField(
                          enabled: !bloquearTextField,
                          onChanged: (value) {
                            setState(() {
                              nombreSesionProv = value;
                            });
                          },
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
                  Text("Rondas: $rondas"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: bloquearDropdown
                            ? null
                            : () {
                                // Lógica para abrir el menú desplegable
                                // Puedes mostrar un diálogo o cambiar el estado según tus necesidades
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Selecciona una hora'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: list.map((String value) {
                                          return ListTile(
                                            title: Text(value),
                                            onTap: () {
                                              setState(() {
                                                selectedTime = value;
                                                Navigator.of(context).pop();
                                              });
                                            },
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
                              style: const TextStyle(
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
                          child: const Text("Iniciar"),
                          onPressed: () {
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
                              horaInicioProv = DateTime(
                                  0, 0, 0, hoy.hour, hoy.minute, hoy.second);
                              ultRegistro.inicSesionP =
                                  horaInicioProv.millisecondsSinceEpoch;
                              bloquearNombre();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Ingresa un nombre de sesión'),
                                backgroundColor: Colors.purple,
                                duration: Duration(seconds: 2),
                              ));
                            }
                          },
                        ),
                        ElevatedButton(
                            child: const Text("Detener"),
                            onPressed: () {
                              if (corriendo) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title:
                                            const Text('¿Terminar la sesión?'),
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
                                              Navigator.pop(context, 'Detener');
                                              cronoVisible = !cronoVisible;
                                              bloquearDropdown = false;
                                              bloquearTextField = false;
                                            },
                                            child: const Text("Detener"),
                                          )
                                        ],
                                      );
                                    });
                              }
                            }),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                detenerCrono();
                                ultRegistro.pomodorosP = tomatesTotales;
                                ultRegistro.numRondasP = rondas;
                              });
                              bloquearDropdown = false;
                              bloquearTextField = false;
                              cronoVisible = !cronoVisible;
                              tSesionProv = selectedTime;
                              //////
                              ultRegistro.nombreSesionP = nombreSesionProv;
                              ultRegistro.tiempoSesionP = tSesionProv;
                              fechaSesionProv =
                                  DateTime(hoy.year, hoy.month, hoy.day);
                              ultRegistro.fechaP =
                                  fechaSesionProv.millisecondsSinceEpoch;
                              DateTime hoy2 = DateTime.now();
                              horaFinProv = DateTime(
                                  0, 0, 0, hoy2.hour, hoy2.minute, hoy2.second);
                              ultRegistro.finSesionP =
                                  horaFinProv.millisecondsSinceEpoch;
                              rondas = 0;
                              tomatesTotales = 0;
                              if (ultRegistro.anotacionesP.isEmpty){
                                ultRegistro.anotacionesP = "Sin comentarios";
                              }
                                await addHistory(ultRegistro);
                            },
                            child: const Text("Finalizar Sesión")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Resultados()));
                            },
                            child: const Text("Ir"))
                      ]),
                  StreamBuilder<Object>(
                      stream: _tomatesStreamController.stream,
                      initialData: tomates,
                      builder: (context, snapshot) {
                        return Text(snapshot.data.toString());
                      }),
                  Card(
                      //margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.outline),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          activado
                                              ? 'assets/tomatePequeño.png'
                                              : 'assets/tomatePrueba.png',
                                          width: 50,
                                          height: 50,
                                        ));
                                  });
                            }),
                      ))
                ],
              );
            },
          ),
          ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                //return const ListTile(title: Text("Hola soy un historial"));
              }),
        ]),
      ),
    );
  }
}
