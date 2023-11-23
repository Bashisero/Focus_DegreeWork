// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class DescansoPom extends StatefulWidget {
  final int tomates;
  final int rondas;
  const DescansoPom({super.key, required this.tomates, required this.rondas});

  @override
  State<DescansoPom> createState() => _DescansoPomState();
}

class _DescansoPomState extends State<DescansoPom> {
  late Timer timerDP;
  int segundosDP = 0;
  bool descTerminado = false;
  final player = AudioPlayer();

  void iniciarDescanso(int totalTimeInSeconds) {
    segundosDP = totalTimeInSeconds;
    timerDP = Timer.periodic(const Duration(seconds: 1), (timer) {
      segundosDP--;
      if (segundosDP == 0) {
        player.setReleaseMode(ReleaseMode.loop);
        player.play(AssetSource('piano.mp3'));
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                  title: const Text("Terminó el descanso"),
                  content: const Text(
                      "¿Qué tal si continúas con lo que estabas haciendo?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          player.stop();
                          Navigator.pop(context);
                          Navigator.pop(context, widget.tomates);
                        },
                        child: const Center(child: Text("Continuar")))
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
    if (widget.tomates == 4) {
      iniciarDescanso(5);
    } else {
      iniciarDescanso(5);
    }
  }

  @override
  void dispose() {
    timerDP.cancel();
    player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                          Navigator.of(context).pop();
                        },
                        child: const Text("Continuar")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            timerDP.cancel();
                          });
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(widget.tomates);
                        },
                        child: const Text("Saltar descanso"))
                  ]);
            });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Descanso",
              style: TextStyle(color: Color(0xFFFAF5F1))),
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
                        style: const TextStyle(
                            fontSize: 60, color: Colors.black54));
                  },
                ),
              ),
            ),
            Image.asset('assets/descansoWombat.png', height: 300, width: 300),
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
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
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
                                Navigator.of(context).pop();
                              },
                              child: const Text("Continuar")),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  timerDP.cancel();
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).pop(widget.tomates);
                              },
                              child: const Text("Saltar descanso"))
                        ]);
                  });
            },
            child:
                const Icon(Icons.skip_next_rounded, color: Color(0xFFFAF5F1))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
