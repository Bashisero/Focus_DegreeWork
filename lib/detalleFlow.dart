// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesis/drift_database.dart';
import 'package:tesis/main.dart';

class DetalleFlow extends StatelessWidget {
  final HistorialFlowData registro;

  const DetalleFlow({super.key, required this.registro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(registro.nombreSesionF,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Flowtime", style: estiloTitulos),
              Image.asset('assets/vientoIcon.png', height: 50, width: 50)
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Fecha:", style: estiloHistoriales),
                  Text(DateFormat('dd/MM/yyyy')
                      .format(registro.fechaSesionF)
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
                      .format(registro.horaInicioF)
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
                      DateFormat('HH:mm').format(registro.horaFinF).toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Interrupciones Internas:",
                      style: estiloHistoriales),
                  Text(registro.internas.toString()),
                  const Icon(Icons.anchor_outlined)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Interrupciones Externas:",
                      style: estiloHistoriales),
                  Text(registro.externas.toString()),
                  const Icon(Icons.sensor_occupied_outlined)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tiempo por sesión:", style: estiloHistoriales),
                    Text(registro.tiempoSesionF),
                  ]),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  // Parte superior con el título "Anotaciones"
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
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3),
                    width: double.infinity, // Ajusta la altura máxima
                    child: SingleChildScrollView(
                      child: Text(
                        registro.anotacionesF,
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
