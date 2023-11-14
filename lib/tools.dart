import 'package:flutter/material.dart';

class Tools extends StatelessWidget {
  const Tools({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de prueba Herramientas"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("A inicio 5"),        // Se borra el contexto, llevando de nuevo al inicio
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

