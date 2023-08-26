import 'dart:async';
import 'package:flutter/material.dart';

class Cronometro extends StatelessWidget {
  final CronometroController controller;

  const Cronometro({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: controller.onUpdate,
      builder: (context, snapshot) {
        return Text(
          controller.formaTiempo(),
        );
      },
    );
  }
}

class CronometroController {
  int segundos = 0;
  bool corriendo = false;
  late Timer timer;

  void iniciarCrono(){
    if(!corriendo){
      corriendo = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        segundos++;
      });
    }else{
      detenerCrono();
    }
  }

  void detenerCrono() {
    if(corriendo){
      corriendo = false;
      timer.cancel();
    }
  }

  Stream<void> get onUpdate{
    return Stream.periodic(const Duration(seconds:1));
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

