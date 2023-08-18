import 'package:flutter/material.dart';

class Historial extends StatelessWidget {
  const Historial({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: const Text("Historial"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("A inicio 6"),        // Se borra el contexto, llevando de nuevo al inicio
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}