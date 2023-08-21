import 'package:flutter/material.dart';

class FlowTime extends StatelessWidget {
  const FlowTime({super.key});

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
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const Text("Flowtime"),
                    ElevatedButton(child: const Text("Esto es una prueba"),
                    onPressed: () => Navigator.pop(context)),
                  ],
                );
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  title: Text("Hola soy un historial")
                );
              }
            ),
          ]
        ),
      ),
    );
  }
}