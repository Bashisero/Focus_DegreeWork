import 'package:flutter/material.dart';
import 'package:tesis/cronometro.dart';
import 'package:tesis/tools.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  final CronometroController controller = CronometroController();

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
                  ElevatedButton(
                      child: const Text("Esto es una prueba"),
                      onPressed: () => Navigator.pop(context)),
                  StreamBuilder<void>(
                    stream: controller.onUpdate,
                    builder: (context, snapshot) {
                      return Text(
                        controller.formaTiempo(),
                      );
                    },
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            child: const Text("Iniciar"),
                            onPressed: () {
                              setState(() {
                                controller.iniciarCrono();
                              });
                            }),
                        ElevatedButton(
                            child: const Text("Detener"),
                            onPressed: () {
                              setState(() {
                                controller.detenerCrono();
                              });
                            })
                      ]),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Tools()));
                      },
                      child: const Text("Herramientas"))
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
