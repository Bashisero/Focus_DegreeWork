import 'package:flutter/material.dart';
import 'package:tesis/achievements.dart';
import 'package:tesis/flowtime.dart';
import 'package:tesis/pomodoro.dart';
import 'package:tesis/projects.dart';
//import 'package:tesis/projects.dart';
import 'package:tesis/tools.dart';

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
  const MyHomePage({Key? key, required this.title,}): super(key: key);

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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  const Pomodoro())); // Navegar a la pantalla de Pomodoro
                  },
                  child: const Text("Pomodoro"),
                ),

                ElevatedButton(                         // Botón FlowTime
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  const FlowTime()));
                  },
                  child: const Text("FlowTime"),        
                )
              ]
            ),
            ElevatedButton(                             // Botón Proyectos
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  const Projects()));
                  },
                  child: const Text("Proyectos"),
                ),

            ElevatedButton(                             // Botón Logros
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  const Achievements()));
                  },
                  child: const Text("Logros"),
                ),
            
            ElevatedButton(                             // Botón Herramientas adicionales
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  const Tools()));
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


