import 'package:flutter/material.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de prueba Proyectos"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("A inicio 3"),        // Se borra el contexto, llevando de nuevo al inicio
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}