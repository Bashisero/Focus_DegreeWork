import 'package:flutter/material.dart';
import 'dart:async';

const List<String> list = <String>["00:05", "15:00", "20:00", "25:00", "30:00"];

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  String selectedTime = "00:05";
  bool cronoVisible = false;
  int tomates = 0;
  int segundos = 0;
  bool corriendo = false;
  late Timer timer;
  final StreamController<int> _tomatesStreamController = StreamController<int>.broadcast();

  void iniciarCrono(int totalTimeInSeconds){
    if(!corriendo){
      corriendo = true;
      segundos = totalTimeInSeconds;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        segundos--;
        if(segundos == 0){
          tomates++;
          _tomatesStreamController.add(tomates);
          detenerCrono();
        }
      });
    }else{
      detenerCrono();
    }
  }

  /*void iniciarCrono(){
    if(!corriendo){
      corriendo = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        segundos++;
      });
    }else{
      detenerCrono();
    }
  }*/

  void detenerCrono() {
    if(corriendo){
      corriendo = false;
      timer.cancel();
    }
  }

  Stream<void> get onUpdate{
    return Stream.periodic(const Duration(seconds:1));
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



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    detenerCrono();
    _tomatesStreamController.close();
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
                  const SizedBox(
                    width: 250,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '¿Qué desea realizar?',
                      ),
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
                  DropdownButton<String>(
                    value: selectedTime,
                    items: list.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTime = newValue!;
                      });
                    },
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: const Text("Iniciar"),
                          onPressed: () {
                            final timeParts = selectedTime.split(':');
                            final minutes = int.parse(timeParts[0]);
                            final seconds = int.parse(timeParts[1]);
                            final totalTimeInSeconds = (minutes * 60) + seconds;
                            setState(() {
                              iniciarCrono(totalTimeInSeconds);
                              cronoVisible = true;
                            });
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
                                        title: const Text('¿Terminar la sesión?'),
                                        content: const Text('Perderás el progreso de este pomodoro si lo haces'),
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
                                              cronoVisible= !cronoVisible;
                                            },
                                            child: const Text("Detener"),
                                          )
                                        ],
                                      );
                                    });
                              }
                            })
                      ]),
                  StreamBuilder<Object>(
                    stream: _tomatesStreamController.stream,
                    initialData: tomates,
                    builder: (context, snapshot) {
                      return Text(snapshot.data.toString());
                    }
                  ),
                  
                  Card(
                    //margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Theme.of(context).colorScheme.outline),
                      borderRadius: const BorderRadius.all(Radius.circular(15))
                    ),
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
                            itemBuilder: (context, index){
                              bool activado = index < tomates;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  activado ? 'assets/tomatePequeño.png' : 'assets/tomatePrueba.png',
                                  width: 50,
                                  height:50,
                                ));
                            }
                            );
                        }
                      ),
                    )
                  )
                ],
              );
            },
          ),
          ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(title: Text("Hola soy un historial"));
              }),
        ]),
      ),
    );
  }
}

