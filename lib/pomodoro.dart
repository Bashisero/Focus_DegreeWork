import 'package:flutter/material.dart';
import 'package:tesis/cronometro.dart';

class Pomodoro extends StatelessWidget {
  final CronometroController _cronometroController;
  const Pomodoro(this._cronometroController, {Key? key}) : super(key: key);

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
                    stream: _cronometroController.onUpdate,
                    builder: (context, snapshot){
                      return Text(_cronometroController.formaTiempo(),);
                    },
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            child: const Text("Iniciar"), onPressed: () {
                              _cronometroController.iniciarCrono(() {
                                
                               });
                            }),
                        
                        ElevatedButton(
                            child: const Text("Detener"), onPressed: () {
                              _cronometroController.detenerCrono();
                            }
                        )
                      ])
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
