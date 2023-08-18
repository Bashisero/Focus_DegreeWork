import 'package:flutter/material.dart';

class Achievements extends StatelessWidget {
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de prueba Logros"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("A inicio 4"),        // Se borra el contexto, llevando de nuevo al inicio
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}