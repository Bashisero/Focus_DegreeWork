import 'package:flutter/material.dart';

class FlowTime extends StatelessWidget {
  const FlowTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de prueba Flowtime"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("A inicio 2"),        // Se borra el contexto, llevando de nuevo al inicio
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}