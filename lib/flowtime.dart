import 'package:flutter/material.dart';
import 'package:tesis/cronometro.dart';

class FlowTime extends StatefulWidget {
  const FlowTime({super.key});

  @override
  State<FlowTime> createState() => _FlowTimeState();
}

class _FlowTimeState extends State<FlowTime> {
  final CronometroController controller = CronometroController();
  int intInternas = 0;
  int intExternas = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flowtime"),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.air),
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
                    child: Image.asset('assets/vientoIcon.png'),
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
                    child: StreamBuilder<void>(
                      stream: controller.onUpdate,
                      builder: (context, snapshot) {
                        return Text(controller.formaTiempo(),
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
                              setState(() {
                                controller.iniciarCrono();
                              });
                            },
                            icon: const Icon(Icons.play_circle_rounded)),
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
                              onPressed: () {
                                intInternas++;
                                setState(() {});
                              },
                              icon: const Icon(Icons.anchor_outlined),
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
                                        fontWeight: FontWeight.bold,),
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
                              onPressed: () {
                                intExternas++;
                                setState(() {});
                              },
                              icon: const Icon(Icons.sensor_occupied_rounded),
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
                                              fontWeight: FontWeight.bold,)))),
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
