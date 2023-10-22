// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tesis/pomodoro.dart';
//import 'pomodoro.dart';
import 'main.dart';
import 'dart:async';

int tomatesTotales = 0;
class DescansoPom extends StatefulWidget {
  const DescansoPom({super.key});

  @override
  State<DescansoPom> createState() => _DescansoPomState();
}

class _DescansoPomState extends State<DescansoPom> {
  late Timer timerDP;
  int segundosDP = 0;
  bool descTerminado = false;

  void obtenerTTotales(){
    tomatesTotales = rondas*4+tomates;
  }

  void iniciarDescanso(int totalTimeInSeconds) {
    segundosDP = totalTimeInSeconds;
    timerDP = Timer.periodic(const Duration(seconds: 1), (timer) {
      segundosDP--;
      if (segundosDP == 0) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                  title: const Text("Bye"),
                  content: const Text("Terminó el descanso"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.popUntil(
                              context, ModalRoute.withName('/pomodoro'));
                          descTerminado = true;
                        },
                        child: const Text("Continuar"))
                  ]);
            });
        timerDP.cancel();
      }
    });
  }

  Stream<void> get onUpdate {
    return Stream.periodic(const Duration(seconds: 1));
  }

  String formaTiempo() {
    Duration duracion = Duration(seconds: segundosDP);

    String dosValores(int valor) {
      return valor < 10 ? "0$valor" : "$valor";
    }

    String horas = dosValores(duracion.inHours);
    String minutos = dosValores(duracion.inMinutes.remainder(60));
    String segundos = dosValores(duracion.inSeconds.remainder(60));

    return "$horas:$minutos:$segundos";
  }

  @override
  void initState() {
    super.initState();
    obtenerTTotales();
    if (tomates == 4) {
      iniciarDescanso(10);
    } else {
      iniciarDescanso(5);
    }
  }

  @override
  void dispose() {
    timerDP.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Fausto"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<void>(
                stream: onUpdate,
                builder: (context, snapshot) {
                  return Text(formaTiempo(),
                      style:
                          const TextStyle(fontSize: 60, color: Colors.black54));
                },
              ),
            ),
          ),
          Image.asset('assets/descanso.gif', height: 300, width: 300),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Visibility(
                visible: descTerminado,
                child: ElevatedButton(
                    // CONTINUAR SESIONES POMODORO
                    onPressed: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/pomodoro'));
                    },
                    child: const Text("Continuar")),
              ),
              Visibility(
                  visible: descTerminado,
                  child: ElevatedButton(      
                    // TERMINAR SESIONES POMODORO
                      onPressed: () {
                        Navigator.pushNamed(context, '/resultados');
                      },
                      child: const Text("Terminar"))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(ultRegistro.nombreSesionP.toString()),
              Text(ultRegistro.fechaP.toString()),
              Text(ultRegistro.inicSesionP.toString()),
              Text(ultRegistro.finSesionP.toString()),
              Text(ultRegistro.numRondasP.toString()),
              Text(ultRegistro.pomodorosP.toString()),
              Text(ultRegistro.tiempoSesionP.toString()),
              Text(ultRegistro.anotacionesP.toString()),
              Text(tomatesTotales.toString())
            ]
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                      title: const Text("¿Saltar descanso?"),
                      content: const Text(
                          "¿Está seguro que desea cancelar su descanso?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.popUntil(context, (ModalRoute.withName('/descansoPom')));
                            },
                            child: const Text("Continuar")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                timerDP.cancel();
                              });
                              Navigator.popUntil(context, (ModalRoute.withName('/pomodoro')));
                            },
                            child: const Text("Saltar descanso"))
                      ]);
                });
          },
          child: const Icon(Icons.flaky)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
