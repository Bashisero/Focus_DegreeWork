import 'dart:async';
import 'package:flutter/material.dart';

class Cronometro extends StatefulWidget {
  final CronometroController _cronometroController;
  const Cronometro(this._cronometroController, {Key? key}) : super(key: key);

  @override
  State<Cronometro> createState() => _CronometroState();
}

class CronometroController {
  int segundos = 0;
  bool corriendo = false;
  late Timer timer;

  final _updateController = StreamController<void>();
  Stream<void> get onUpdate => _updateController.stream;

  void iniciarCrono(VoidCallback onTick) {
    if (!corriendo) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        segundos++;
        _updateController.add(null);
      });
    }
    corriendo = true;
  }

  void detenerCrono() {
    timer.cancel();
    corriendo = false;
  }

  String formaTiempo() {
    Duration duracion = Duration(seconds: this.segundos);

    String dosValores(int valor) {
      return valor < 10 ? "0$valor" : "$valor";
    }

    String horas = dosValores(duracion.inHours);
    String minutos = dosValores(duracion.inMinutes.remainder(60));
    String segundos = dosValores(duracion.inSeconds.remainder(60));

    return "$horas:$minutos:$segundos";
  }
}

class _CronometroState extends State<Cronometro> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget._cronometroController.formaTiempo(),
          style: const TextStyle(fontSize: 50),
        ),
        OutlinedButton(
          onPressed: () {
            widget._cronometroController.iniciarCrono(() {
              setState(() {});
            });
          },
          child: const Text("Hola"),
        ),
        OutlinedButton(
            onPressed: widget._cronometroController.detenerCrono,
            child: const Text("Adiós")),
      ],
    );
  }
}
