//import 'main.dart';
import 'package:flutter/material.dart';
//import 'focusdb.dart';
import 'pomodoro.dart';
import 'package:intl/intl.dart';

class Resultados extends StatelessWidget {
  const Resultados({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados de la sesión"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text("Tiempo de las sesiones: ${ultRegistro.tiempoSesionP}"),
        Text("Nombre de la sesión: ${ultRegistro.nombreSesionP}"),
        Text("Pomodoros: ${ultRegistro.pomodorosP.toString()}"),
        Text(DateFormat('dd/MM/yyyy').format(fechaSesionProv)),
        Text("Fecha de la sesión: ${ultRegistro.fechaP.toString()}"),
        Text("Hora de inicio: ${DateFormat('HH:mm:ss').format(horaInicioProv)}"),
        Text("Hora de finalización: ${DateFormat('HH:mm:ss').format(horaFinProv)}"),
        Text("Número de rondas: ${ultRegistro.numRondasP.toString()}"),
        Text(ultRegistro.anotacionesP),
        
        ElevatedButton(
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName('/pomodoro'));
          }, child: const Text("Salir"),
        ),
      ]),
    );
  }
}
