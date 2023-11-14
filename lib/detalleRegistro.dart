// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesis/drift_database.dart';
import 'package:tesis/main.dart';

class DetalleRegistro extends StatelessWidget {
  final HistorialPomData registro;

  const DetalleRegistro({super.key, required this.registro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(registro.nombreSesionP),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Pomodoro", style: estiloTitulos),
              Image.asset('assets/tomatePequeño.png', height: 50, width: 50)
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Fecha:", style: estiloHistoriales),
                  Text(DateFormat('dd/MM/yyyy')
                      .format(registro.fechaSesionP)
                      .toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Inicio de la sesión:", style: estiloHistoriales),
                  Text(DateFormat('HH:mm')
                      .format(registro.horaInicioP)
                      .toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Fin de la sesión:", style: estiloHistoriales),
                  Text(
                      DateFormat('HH:mm').format(registro.horaFinP).toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pomodoros:", style: estiloHistoriales),
                  Row(
                    children: List.generate(
                      (registro.pomodorosP ~/ 4)
                          .clamp(0, 3), // Calcula la cantidad de rondas
                      (index) => Image.asset('assets/tomatePequeño.png',
                          height: 30, width: 30),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Rondas de 4 Pomodoros:", style: estiloHistoriales),
                  Row(
                    children: List.generate(
                      registro.rondasP,
                      (index) => Image.asset('assets/tomatePequeñoRonda.png',
                          height: 30, width: 30),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tiempo por sesión:", style: estiloHistoriales),
                    Text(registro.tiempoSesionP.toString()),
                  ]),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  // Parte superior con el título "Anotaciones" en un cuadro rojo
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      color: const Color.fromARGB(255, 15, 182, 182),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: double.infinity,
                      child: const Text(
                        "Anotaciones",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Parte inferior con el texto de registro.anotaciones en un cuadro blanco
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    constraints: const BoxConstraints(maxHeight: 250),
                    width: double.infinity, // Ajusta la altura máxima
                    child: SingleChildScrollView(
                      child: Text(
                        registro.anotacionesP,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
