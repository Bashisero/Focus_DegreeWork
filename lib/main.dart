import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,    // Remove the debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hola'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(                   // Botón Pomodoro
                  onPressed: () {},
                  child: const Text("Pomodoro"),
                ),

                ElevatedButton(                         // Botón FlowTime
                  onPressed: () {
                  },
                  child: const Text("FlowTime"),        
                )
              ]
            ),
            ElevatedButton(                             // Botón Proyectos
                  onPressed: () {
                  },
                  child: const Text("Proyectos"),
                ),

            ElevatedButton(                             // Botón Logros
                  onPressed: () {
                  },
                  child: const Text("Logros"),
                ),
            
            ElevatedButton(                             // Botón Herramientas adicionales
                  onPressed: () {
                  },
                  child: const Text("Herramientas adicionales"),  
                ),

            Container(
              color: Colors.lightBlueAccent,
              width: 300, height: 150,
              margin: const EdgeInsets.all(40.0),
              child: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vestibulum mauris non dui sollicitudin consequat. Aliquam et massa ornare, tempus enim id, faucibus odio. Nullam laoreet porta mi at tincidunt. Fusce dapibus pharetra ex sed finibus. Etiam luctus elit sed nibh tincidunt bibendum. '),
            )
          ],
        ),
      ),
    );
  }
}
