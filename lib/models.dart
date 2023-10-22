class RegistroPom {
  // REGISTROS POMODORO
  String nombreSesionP;
  int fechaP;
  int inicSesionP;
  int finSesionP;
  int pomodorosP;
  int numRondasP;
  String tiempoSesionP;
  String anotacionesP;

  RegistroPom.empty()
      : nombreSesionP = '',
        fechaP = 0,
        inicSesionP = 0,
        finSesionP = 0,
        pomodorosP = 0,
        numRondasP = 0,
        tiempoSesionP = '',
        anotacionesP = '';

  RegistroPom(
      {required this.nombreSesionP,
      required this.fechaP,
      required this.inicSesionP,
      required this.finSesionP,
      required this.pomodorosP,
      required this.numRondasP,
      required this.tiempoSesionP,
      required this.anotacionesP});

  int formatDateTimeToTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  Map<String, dynamic> toMapP() {
    return {
      'nombreSesionP': nombreSesionP,
      'fechaSesionP': fechaP,
      'horaInicioP': inicSesionP,
      'horaFinP': finSesionP,
      'pomodoros': pomodorosP,
      'rondas': numRondasP,
      'tiempoSesionP': tiempoSesionP,
      'anotacionesP': anotacionesP
    };
  }

  factory RegistroPom.fromMap(Map<String, dynamic> map) {
    return RegistroPom(
      nombreSesionP: map['nombreSesionP'],
      fechaP: map['fechaSesionP'],
      inicSesionP: map['horaInicioP'],
      finSesionP: map['horaFinP'],
      pomodorosP: map['pomodoros'],
      numRondasP: map['rondas'],
      tiempoSesionP: map['tiempoSesionP'],
      anotacionesP: map['anotacionesP'],
    );
  }
}

class RegistroFlow {
  // REGISTROS FLOWTIME
  final int idF;
  final String nombreF;
  final int fechaF;
  final int inicSesionF;
  final int finSesionF;
  final int internas;
  final int externas;
  final int tiempoSesionF;
  final String anotacionesF;

  RegistroFlow(
      this.idF,
      this.nombreF,
      this.fechaF,
      this.inicSesionF,
      this.finSesionF,
      this.internas,
      this.externas,
      this.tiempoSesionF,
      this.anotacionesF);

  Map<String, dynamic> toMapF() {
    return {
      'id': idF,
      'nombre': nombreF,
      'fecha': fechaF,
      'inicSesion': inicSesionF,
      'finSesion': finSesionF,
      'internas': internas,
      'externas': externas,
      'tiempoSesion': tiempoSesionF,
      'anotaciones': anotacionesF,
    };
  }
}
