// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $HistorialPomTable extends HistorialPom
    with TableInfo<$HistorialPomTable, HistorialPomData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorialPomTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idPMeta = const VerificationMeta('idP');
  @override
  late final GeneratedColumn<int> idP = GeneratedColumn<int>(
      'id_p', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreSesionPMeta =
      const VerificationMeta('nombreSesionP');
  @override
  late final GeneratedColumn<String> nombreSesionP = GeneratedColumn<String>(
      'Sesión Pomodoro', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaSesionPMeta =
      const VerificationMeta('fechaSesionP');
  @override
  late final GeneratedColumn<DateTime> fechaSesionP = GeneratedColumn<DateTime>(
      'Fecha del Pomodoro', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _horaInicioPMeta =
      const VerificationMeta('horaInicioP');
  @override
  late final GeneratedColumn<DateTime> horaInicioP = GeneratedColumn<DateTime>(
      'Hora de la sesión Pom', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _horaFinPMeta =
      const VerificationMeta('horaFinP');
  @override
  late final GeneratedColumn<DateTime> horaFinP = GeneratedColumn<DateTime>(
      'Hora de finalización Pom', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _pomodorosPMeta =
      const VerificationMeta('pomodorosP');
  @override
  late final GeneratedColumn<int> pomodorosP = GeneratedColumn<int>(
      'Pomodoros hechos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rondasPMeta =
      const VerificationMeta('rondasP');
  @override
  late final GeneratedColumn<int> rondasP = GeneratedColumn<int>(
      'Rondas hechas', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tiempoSesionPMeta =
      const VerificationMeta('tiempoSesionP');
  @override
  late final GeneratedColumn<String> tiempoSesionP = GeneratedColumn<String>(
      'Tiempo de las sesiones', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _anotacionesPMeta =
      const VerificationMeta('anotacionesP');
  @override
  late final GeneratedColumn<String> anotacionesP = GeneratedColumn<String>(
      'Anotaciones Pomodoro', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        idP,
        nombreSesionP,
        fechaSesionP,
        horaInicioP,
        horaFinP,
        pomodorosP,
        rondasP,
        tiempoSesionP,
        anotacionesP
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historial_pom';
  @override
  VerificationContext validateIntegrity(Insertable<HistorialPomData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_p')) {
      context.handle(
          _idPMeta, idP.isAcceptableOrUnknown(data['id_p']!, _idPMeta));
    }
    if (data.containsKey('Sesión Pomodoro')) {
      context.handle(
          _nombreSesionPMeta,
          nombreSesionP.isAcceptableOrUnknown(
              data['Sesión Pomodoro']!, _nombreSesionPMeta));
    } else if (isInserting) {
      context.missing(_nombreSesionPMeta);
    }
    if (data.containsKey('Fecha del Pomodoro')) {
      context.handle(
          _fechaSesionPMeta,
          fechaSesionP.isAcceptableOrUnknown(
              data['Fecha del Pomodoro']!, _fechaSesionPMeta));
    } else if (isInserting) {
      context.missing(_fechaSesionPMeta);
    }
    if (data.containsKey('Hora de la sesión Pom')) {
      context.handle(
          _horaInicioPMeta,
          horaInicioP.isAcceptableOrUnknown(
              data['Hora de la sesión Pom']!, _horaInicioPMeta));
    } else if (isInserting) {
      context.missing(_horaInicioPMeta);
    }
    if (data.containsKey('Hora de finalización Pom')) {
      context.handle(
          _horaFinPMeta,
          horaFinP.isAcceptableOrUnknown(
              data['Hora de finalización Pom']!, _horaFinPMeta));
    } else if (isInserting) {
      context.missing(_horaFinPMeta);
    }
    if (data.containsKey('Pomodoros hechos')) {
      context.handle(
          _pomodorosPMeta,
          pomodorosP.isAcceptableOrUnknown(
              data['Pomodoros hechos']!, _pomodorosPMeta));
    } else if (isInserting) {
      context.missing(_pomodorosPMeta);
    }
    if (data.containsKey('Rondas hechas')) {
      context.handle(_rondasPMeta,
          rondasP.isAcceptableOrUnknown(data['Rondas hechas']!, _rondasPMeta));
    } else if (isInserting) {
      context.missing(_rondasPMeta);
    }
    if (data.containsKey('Tiempo de las sesiones')) {
      context.handle(
          _tiempoSesionPMeta,
          tiempoSesionP.isAcceptableOrUnknown(
              data['Tiempo de las sesiones']!, _tiempoSesionPMeta));
    } else if (isInserting) {
      context.missing(_tiempoSesionPMeta);
    }
    if (data.containsKey('Anotaciones Pomodoro')) {
      context.handle(
          _anotacionesPMeta,
          anotacionesP.isAcceptableOrUnknown(
              data['Anotaciones Pomodoro']!, _anotacionesPMeta));
    } else if (isInserting) {
      context.missing(_anotacionesPMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idP};
  @override
  HistorialPomData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistorialPomData(
      idP: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_p'])!,
      nombreSesionP: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}Sesión Pomodoro'])!,
      fechaSesionP: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}Fecha del Pomodoro'])!,
      horaInicioP: attachedDatabase.typeMapping.read(DriftSqlType.dateTime,
          data['${effectivePrefix}Hora de la sesión Pom'])!,
      horaFinP: attachedDatabase.typeMapping.read(DriftSqlType.dateTime,
          data['${effectivePrefix}Hora de finalización Pom'])!,
      pomodorosP: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}Pomodoros hechos'])!,
      rondasP: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}Rondas hechas'])!,
      tiempoSesionP: attachedDatabase.typeMapping.read(DriftSqlType.string,
          data['${effectivePrefix}Tiempo de las sesiones'])!,
      anotacionesP: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}Anotaciones Pomodoro'])!,
    );
  }

  @override
  $HistorialPomTable createAlias(String alias) {
    return $HistorialPomTable(attachedDatabase, alias);
  }
}

class HistorialPomData extends DataClass
    implements Insertable<HistorialPomData> {
  final int idP;
  final String nombreSesionP;
  final DateTime fechaSesionP;
  final DateTime horaInicioP;
  final DateTime horaFinP;
  final int pomodorosP;
  final int rondasP;
  final String tiempoSesionP;
  final String anotacionesP;
  const HistorialPomData(
      {required this.idP,
      required this.nombreSesionP,
      required this.fechaSesionP,
      required this.horaInicioP,
      required this.horaFinP,
      required this.pomodorosP,
      required this.rondasP,
      required this.tiempoSesionP,
      required this.anotacionesP});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_p'] = Variable<int>(idP);
    map['Sesión Pomodoro'] = Variable<String>(nombreSesionP);
    map['Fecha del Pomodoro'] = Variable<DateTime>(fechaSesionP);
    map['Hora de la sesión Pom'] = Variable<DateTime>(horaInicioP);
    map['Hora de finalización Pom'] = Variable<DateTime>(horaFinP);
    map['Pomodoros hechos'] = Variable<int>(pomodorosP);
    map['Rondas hechas'] = Variable<int>(rondasP);
    map['Tiempo de las sesiones'] = Variable<String>(tiempoSesionP);
    map['Anotaciones Pomodoro'] = Variable<String>(anotacionesP);
    return map;
  }

  HistorialPomCompanion toCompanion(bool nullToAbsent) {
    return HistorialPomCompanion(
      idP: Value(idP),
      nombreSesionP: Value(nombreSesionP),
      fechaSesionP: Value(fechaSesionP),
      horaInicioP: Value(horaInicioP),
      horaFinP: Value(horaFinP),
      pomodorosP: Value(pomodorosP),
      rondasP: Value(rondasP),
      tiempoSesionP: Value(tiempoSesionP),
      anotacionesP: Value(anotacionesP),
    );
  }

  factory HistorialPomData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistorialPomData(
      idP: serializer.fromJson<int>(json['idP']),
      nombreSesionP: serializer.fromJson<String>(json['nombreSesionP']),
      fechaSesionP: serializer.fromJson<DateTime>(json['fechaSesionP']),
      horaInicioP: serializer.fromJson<DateTime>(json['horaInicioP']),
      horaFinP: serializer.fromJson<DateTime>(json['horaFinP']),
      pomodorosP: serializer.fromJson<int>(json['pomodorosP']),
      rondasP: serializer.fromJson<int>(json['rondasP']),
      tiempoSesionP: serializer.fromJson<String>(json['tiempoSesionP']),
      anotacionesP: serializer.fromJson<String>(json['anotacionesP']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idP': serializer.toJson<int>(idP),
      'nombreSesionP': serializer.toJson<String>(nombreSesionP),
      'fechaSesionP': serializer.toJson<DateTime>(fechaSesionP),
      'horaInicioP': serializer.toJson<DateTime>(horaInicioP),
      'horaFinP': serializer.toJson<DateTime>(horaFinP),
      'pomodorosP': serializer.toJson<int>(pomodorosP),
      'rondasP': serializer.toJson<int>(rondasP),
      'tiempoSesionP': serializer.toJson<String>(tiempoSesionP),
      'anotacionesP': serializer.toJson<String>(anotacionesP),
    };
  }

  HistorialPomData copyWith(
          {int? idP,
          String? nombreSesionP,
          DateTime? fechaSesionP,
          DateTime? horaInicioP,
          DateTime? horaFinP,
          int? pomodorosP,
          int? rondasP,
          String? tiempoSesionP,
          String? anotacionesP}) =>
      HistorialPomData(
        idP: idP ?? this.idP,
        nombreSesionP: nombreSesionP ?? this.nombreSesionP,
        fechaSesionP: fechaSesionP ?? this.fechaSesionP,
        horaInicioP: horaInicioP ?? this.horaInicioP,
        horaFinP: horaFinP ?? this.horaFinP,
        pomodorosP: pomodorosP ?? this.pomodorosP,
        rondasP: rondasP ?? this.rondasP,
        tiempoSesionP: tiempoSesionP ?? this.tiempoSesionP,
        anotacionesP: anotacionesP ?? this.anotacionesP,
      );
  @override
  String toString() {
    return (StringBuffer('HistorialPomData(')
          ..write('idP: $idP, ')
          ..write('nombreSesionP: $nombreSesionP, ')
          ..write('fechaSesionP: $fechaSesionP, ')
          ..write('horaInicioP: $horaInicioP, ')
          ..write('horaFinP: $horaFinP, ')
          ..write('pomodorosP: $pomodorosP, ')
          ..write('rondasP: $rondasP, ')
          ..write('tiempoSesionP: $tiempoSesionP, ')
          ..write('anotacionesP: $anotacionesP')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idP, nombreSesionP, fechaSesionP, horaInicioP,
      horaFinP, pomodorosP, rondasP, tiempoSesionP, anotacionesP);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorialPomData &&
          other.idP == this.idP &&
          other.nombreSesionP == this.nombreSesionP &&
          other.fechaSesionP == this.fechaSesionP &&
          other.horaInicioP == this.horaInicioP &&
          other.horaFinP == this.horaFinP &&
          other.pomodorosP == this.pomodorosP &&
          other.rondasP == this.rondasP &&
          other.tiempoSesionP == this.tiempoSesionP &&
          other.anotacionesP == this.anotacionesP);
}

class HistorialPomCompanion extends UpdateCompanion<HistorialPomData> {
  final Value<int> idP;
  final Value<String> nombreSesionP;
  final Value<DateTime> fechaSesionP;
  final Value<DateTime> horaInicioP;
  final Value<DateTime> horaFinP;
  final Value<int> pomodorosP;
  final Value<int> rondasP;
  final Value<String> tiempoSesionP;
  final Value<String> anotacionesP;
  const HistorialPomCompanion({
    this.idP = const Value.absent(),
    this.nombreSesionP = const Value.absent(),
    this.fechaSesionP = const Value.absent(),
    this.horaInicioP = const Value.absent(),
    this.horaFinP = const Value.absent(),
    this.pomodorosP = const Value.absent(),
    this.rondasP = const Value.absent(),
    this.tiempoSesionP = const Value.absent(),
    this.anotacionesP = const Value.absent(),
  });
  HistorialPomCompanion.insert({
    this.idP = const Value.absent(),
    required String nombreSesionP,
    required DateTime fechaSesionP,
    required DateTime horaInicioP,
    required DateTime horaFinP,
    required int pomodorosP,
    required int rondasP,
    required String tiempoSesionP,
    required String anotacionesP,
  })  : nombreSesionP = Value(nombreSesionP),
        fechaSesionP = Value(fechaSesionP),
        horaInicioP = Value(horaInicioP),
        horaFinP = Value(horaFinP),
        pomodorosP = Value(pomodorosP),
        rondasP = Value(rondasP),
        tiempoSesionP = Value(tiempoSesionP),
        anotacionesP = Value(anotacionesP);
  static Insertable<HistorialPomData> custom({
    Expression<int>? idP,
    Expression<String>? nombreSesionP,
    Expression<DateTime>? fechaSesionP,
    Expression<DateTime>? horaInicioP,
    Expression<DateTime>? horaFinP,
    Expression<int>? pomodorosP,
    Expression<int>? rondasP,
    Expression<String>? tiempoSesionP,
    Expression<String>? anotacionesP,
  }) {
    return RawValuesInsertable({
      if (idP != null) 'id_p': idP,
      if (nombreSesionP != null) 'Sesión Pomodoro': nombreSesionP,
      if (fechaSesionP != null) 'Fecha del Pomodoro': fechaSesionP,
      if (horaInicioP != null) 'Hora de la sesión Pom': horaInicioP,
      if (horaFinP != null) 'Hora de finalización Pom': horaFinP,
      if (pomodorosP != null) 'Pomodoros hechos': pomodorosP,
      if (rondasP != null) 'Rondas hechas': rondasP,
      if (tiempoSesionP != null) 'Tiempo de las sesiones': tiempoSesionP,
      if (anotacionesP != null) 'Anotaciones Pomodoro': anotacionesP,
    });
  }

  HistorialPomCompanion copyWith(
      {Value<int>? idP,
      Value<String>? nombreSesionP,
      Value<DateTime>? fechaSesionP,
      Value<DateTime>? horaInicioP,
      Value<DateTime>? horaFinP,
      Value<int>? pomodorosP,
      Value<int>? rondasP,
      Value<String>? tiempoSesionP,
      Value<String>? anotacionesP}) {
    return HistorialPomCompanion(
      idP: idP ?? this.idP,
      nombreSesionP: nombreSesionP ?? this.nombreSesionP,
      fechaSesionP: fechaSesionP ?? this.fechaSesionP,
      horaInicioP: horaInicioP ?? this.horaInicioP,
      horaFinP: horaFinP ?? this.horaFinP,
      pomodorosP: pomodorosP ?? this.pomodorosP,
      rondasP: rondasP ?? this.rondasP,
      tiempoSesionP: tiempoSesionP ?? this.tiempoSesionP,
      anotacionesP: anotacionesP ?? this.anotacionesP,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idP.present) {
      map['id_p'] = Variable<int>(idP.value);
    }
    if (nombreSesionP.present) {
      map['Sesión Pomodoro'] = Variable<String>(nombreSesionP.value);
    }
    if (fechaSesionP.present) {
      map['Fecha del Pomodoro'] = Variable<DateTime>(fechaSesionP.value);
    }
    if (horaInicioP.present) {
      map['Hora de la sesión Pom'] = Variable<DateTime>(horaInicioP.value);
    }
    if (horaFinP.present) {
      map['Hora de finalización Pom'] = Variable<DateTime>(horaFinP.value);
    }
    if (pomodorosP.present) {
      map['Pomodoros hechos'] = Variable<int>(pomodorosP.value);
    }
    if (rondasP.present) {
      map['Rondas hechas'] = Variable<int>(rondasP.value);
    }
    if (tiempoSesionP.present) {
      map['Tiempo de las sesiones'] = Variable<String>(tiempoSesionP.value);
    }
    if (anotacionesP.present) {
      map['Anotaciones Pomodoro'] = Variable<String>(anotacionesP.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorialPomCompanion(')
          ..write('idP: $idP, ')
          ..write('nombreSesionP: $nombreSesionP, ')
          ..write('fechaSesionP: $fechaSesionP, ')
          ..write('horaInicioP: $horaInicioP, ')
          ..write('horaFinP: $horaFinP, ')
          ..write('pomodorosP: $pomodorosP, ')
          ..write('rondasP: $rondasP, ')
          ..write('tiempoSesionP: $tiempoSesionP, ')
          ..write('anotacionesP: $anotacionesP')
          ..write(')'))
        .toString();
  }
}

class $HistorialFlowTable extends HistorialFlow
    with TableInfo<$HistorialFlowTable, HistorialFlowData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorialFlowTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idFMeta = const VerificationMeta('idF');
  @override
  late final GeneratedColumn<int> idF = GeneratedColumn<int>(
      'id_f', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreSesionFMeta =
      const VerificationMeta('nombreSesionF');
  @override
  late final GeneratedColumn<String> nombreSesionF = GeneratedColumn<String>(
      'Sesión Flowtime', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaSesionFMeta =
      const VerificationMeta('fechaSesionF');
  @override
  late final GeneratedColumn<DateTime> fechaSesionF = GeneratedColumn<DateTime>(
      'Fecha del Flowtime', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _horaInicioFMeta =
      const VerificationMeta('horaInicioF');
  @override
  late final GeneratedColumn<DateTime> horaInicioF = GeneratedColumn<DateTime>(
      'Hora del Flowtime', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _horaFinFMeta =
      const VerificationMeta('horaFinF');
  @override
  late final GeneratedColumn<DateTime> horaFinF = GeneratedColumn<DateTime>(
      'Hora de finalización Flow', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _internasMeta =
      const VerificationMeta('internas');
  @override
  late final GeneratedColumn<int> internas = GeneratedColumn<int>(
      'Interrupciones Internas', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _externasMeta =
      const VerificationMeta('externas');
  @override
  late final GeneratedColumn<int> externas = GeneratedColumn<int>(
      'Interrupciones Externas', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tiempoSesionFMeta =
      const VerificationMeta('tiempoSesionF');
  @override
  late final GeneratedColumn<String> tiempoSesionF = GeneratedColumn<String>(
      'Tiempo trabajado', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _anotacionesFMeta =
      const VerificationMeta('anotacionesF');
  @override
  late final GeneratedColumn<String> anotacionesF = GeneratedColumn<String>(
      'Anotaciones Flowtime', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        idF,
        nombreSesionF,
        fechaSesionF,
        horaInicioF,
        horaFinF,
        internas,
        externas,
        tiempoSesionF,
        anotacionesF
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historial_flow';
  @override
  VerificationContext validateIntegrity(Insertable<HistorialFlowData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_f')) {
      context.handle(
          _idFMeta, idF.isAcceptableOrUnknown(data['id_f']!, _idFMeta));
    }
    if (data.containsKey('Sesión Flowtime')) {
      context.handle(
          _nombreSesionFMeta,
          nombreSesionF.isAcceptableOrUnknown(
              data['Sesión Flowtime']!, _nombreSesionFMeta));
    } else if (isInserting) {
      context.missing(_nombreSesionFMeta);
    }
    if (data.containsKey('Fecha del Flowtime')) {
      context.handle(
          _fechaSesionFMeta,
          fechaSesionF.isAcceptableOrUnknown(
              data['Fecha del Flowtime']!, _fechaSesionFMeta));
    } else if (isInserting) {
      context.missing(_fechaSesionFMeta);
    }
    if (data.containsKey('Hora del Flowtime')) {
      context.handle(
          _horaInicioFMeta,
          horaInicioF.isAcceptableOrUnknown(
              data['Hora del Flowtime']!, _horaInicioFMeta));
    } else if (isInserting) {
      context.missing(_horaInicioFMeta);
    }
    if (data.containsKey('Hora de finalización Flow')) {
      context.handle(
          _horaFinFMeta,
          horaFinF.isAcceptableOrUnknown(
              data['Hora de finalización Flow']!, _horaFinFMeta));
    } else if (isInserting) {
      context.missing(_horaFinFMeta);
    }
    if (data.containsKey('Interrupciones Internas')) {
      context.handle(
          _internasMeta,
          internas.isAcceptableOrUnknown(
              data['Interrupciones Internas']!, _internasMeta));
    } else if (isInserting) {
      context.missing(_internasMeta);
    }
    if (data.containsKey('Interrupciones Externas')) {
      context.handle(
          _externasMeta,
          externas.isAcceptableOrUnknown(
              data['Interrupciones Externas']!, _externasMeta));
    } else if (isInserting) {
      context.missing(_externasMeta);
    }
    if (data.containsKey('Tiempo trabajado')) {
      context.handle(
          _tiempoSesionFMeta,
          tiempoSesionF.isAcceptableOrUnknown(
              data['Tiempo trabajado']!, _tiempoSesionFMeta));
    } else if (isInserting) {
      context.missing(_tiempoSesionFMeta);
    }
    if (data.containsKey('Anotaciones Flowtime')) {
      context.handle(
          _anotacionesFMeta,
          anotacionesF.isAcceptableOrUnknown(
              data['Anotaciones Flowtime']!, _anotacionesFMeta));
    } else if (isInserting) {
      context.missing(_anotacionesFMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idF};
  @override
  HistorialFlowData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistorialFlowData(
      idF: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_f'])!,
      nombreSesionF: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}Sesión Flowtime'])!,
      fechaSesionF: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}Fecha del Flowtime'])!,
      horaInicioF: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}Hora del Flowtime'])!,
      horaFinF: attachedDatabase.typeMapping.read(DriftSqlType.dateTime,
          data['${effectivePrefix}Hora de finalización Flow'])!,
      internas: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}Interrupciones Internas'])!,
      externas: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}Interrupciones Externas'])!,
      tiempoSesionF: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}Tiempo trabajado'])!,
      anotacionesF: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}Anotaciones Flowtime'])!,
    );
  }

  @override
  $HistorialFlowTable createAlias(String alias) {
    return $HistorialFlowTable(attachedDatabase, alias);
  }
}

class HistorialFlowData extends DataClass
    implements Insertable<HistorialFlowData> {
  final int idF;
  final String nombreSesionF;
  final DateTime fechaSesionF;
  final DateTime horaInicioF;
  final DateTime horaFinF;
  final int internas;
  final int externas;
  final String tiempoSesionF;
  final String anotacionesF;
  const HistorialFlowData(
      {required this.idF,
      required this.nombreSesionF,
      required this.fechaSesionF,
      required this.horaInicioF,
      required this.horaFinF,
      required this.internas,
      required this.externas,
      required this.tiempoSesionF,
      required this.anotacionesF});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_f'] = Variable<int>(idF);
    map['Sesión Flowtime'] = Variable<String>(nombreSesionF);
    map['Fecha del Flowtime'] = Variable<DateTime>(fechaSesionF);
    map['Hora del Flowtime'] = Variable<DateTime>(horaInicioF);
    map['Hora de finalización Flow'] = Variable<DateTime>(horaFinF);
    map['Interrupciones Internas'] = Variable<int>(internas);
    map['Interrupciones Externas'] = Variable<int>(externas);
    map['Tiempo trabajado'] = Variable<String>(tiempoSesionF);
    map['Anotaciones Flowtime'] = Variable<String>(anotacionesF);
    return map;
  }

  HistorialFlowCompanion toCompanion(bool nullToAbsent) {
    return HistorialFlowCompanion(
      idF: Value(idF),
      nombreSesionF: Value(nombreSesionF),
      fechaSesionF: Value(fechaSesionF),
      horaInicioF: Value(horaInicioF),
      horaFinF: Value(horaFinF),
      internas: Value(internas),
      externas: Value(externas),
      tiempoSesionF: Value(tiempoSesionF),
      anotacionesF: Value(anotacionesF),
    );
  }

  factory HistorialFlowData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistorialFlowData(
      idF: serializer.fromJson<int>(json['idF']),
      nombreSesionF: serializer.fromJson<String>(json['nombreSesionF']),
      fechaSesionF: serializer.fromJson<DateTime>(json['fechaSesionF']),
      horaInicioF: serializer.fromJson<DateTime>(json['horaInicioF']),
      horaFinF: serializer.fromJson<DateTime>(json['horaFinF']),
      internas: serializer.fromJson<int>(json['internas']),
      externas: serializer.fromJson<int>(json['externas']),
      tiempoSesionF: serializer.fromJson<String>(json['tiempoSesionF']),
      anotacionesF: serializer.fromJson<String>(json['anotacionesF']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idF': serializer.toJson<int>(idF),
      'nombreSesionF': serializer.toJson<String>(nombreSesionF),
      'fechaSesionF': serializer.toJson<DateTime>(fechaSesionF),
      'horaInicioF': serializer.toJson<DateTime>(horaInicioF),
      'horaFinF': serializer.toJson<DateTime>(horaFinF),
      'internas': serializer.toJson<int>(internas),
      'externas': serializer.toJson<int>(externas),
      'tiempoSesionF': serializer.toJson<String>(tiempoSesionF),
      'anotacionesF': serializer.toJson<String>(anotacionesF),
    };
  }

  HistorialFlowData copyWith(
          {int? idF,
          String? nombreSesionF,
          DateTime? fechaSesionF,
          DateTime? horaInicioF,
          DateTime? horaFinF,
          int? internas,
          int? externas,
          String? tiempoSesionF,
          String? anotacionesF}) =>
      HistorialFlowData(
        idF: idF ?? this.idF,
        nombreSesionF: nombreSesionF ?? this.nombreSesionF,
        fechaSesionF: fechaSesionF ?? this.fechaSesionF,
        horaInicioF: horaInicioF ?? this.horaInicioF,
        horaFinF: horaFinF ?? this.horaFinF,
        internas: internas ?? this.internas,
        externas: externas ?? this.externas,
        tiempoSesionF: tiempoSesionF ?? this.tiempoSesionF,
        anotacionesF: anotacionesF ?? this.anotacionesF,
      );
  @override
  String toString() {
    return (StringBuffer('HistorialFlowData(')
          ..write('idF: $idF, ')
          ..write('nombreSesionF: $nombreSesionF, ')
          ..write('fechaSesionF: $fechaSesionF, ')
          ..write('horaInicioF: $horaInicioF, ')
          ..write('horaFinF: $horaFinF, ')
          ..write('internas: $internas, ')
          ..write('externas: $externas, ')
          ..write('tiempoSesionF: $tiempoSesionF, ')
          ..write('anotacionesF: $anotacionesF')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idF, nombreSesionF, fechaSesionF, horaInicioF,
      horaFinF, internas, externas, tiempoSesionF, anotacionesF);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorialFlowData &&
          other.idF == this.idF &&
          other.nombreSesionF == this.nombreSesionF &&
          other.fechaSesionF == this.fechaSesionF &&
          other.horaInicioF == this.horaInicioF &&
          other.horaFinF == this.horaFinF &&
          other.internas == this.internas &&
          other.externas == this.externas &&
          other.tiempoSesionF == this.tiempoSesionF &&
          other.anotacionesF == this.anotacionesF);
}

class HistorialFlowCompanion extends UpdateCompanion<HistorialFlowData> {
  final Value<int> idF;
  final Value<String> nombreSesionF;
  final Value<DateTime> fechaSesionF;
  final Value<DateTime> horaInicioF;
  final Value<DateTime> horaFinF;
  final Value<int> internas;
  final Value<int> externas;
  final Value<String> tiempoSesionF;
  final Value<String> anotacionesF;
  const HistorialFlowCompanion({
    this.idF = const Value.absent(),
    this.nombreSesionF = const Value.absent(),
    this.fechaSesionF = const Value.absent(),
    this.horaInicioF = const Value.absent(),
    this.horaFinF = const Value.absent(),
    this.internas = const Value.absent(),
    this.externas = const Value.absent(),
    this.tiempoSesionF = const Value.absent(),
    this.anotacionesF = const Value.absent(),
  });
  HistorialFlowCompanion.insert({
    this.idF = const Value.absent(),
    required String nombreSesionF,
    required DateTime fechaSesionF,
    required DateTime horaInicioF,
    required DateTime horaFinF,
    required int internas,
    required int externas,
    required String tiempoSesionF,
    required String anotacionesF,
  })  : nombreSesionF = Value(nombreSesionF),
        fechaSesionF = Value(fechaSesionF),
        horaInicioF = Value(horaInicioF),
        horaFinF = Value(horaFinF),
        internas = Value(internas),
        externas = Value(externas),
        tiempoSesionF = Value(tiempoSesionF),
        anotacionesF = Value(anotacionesF);
  static Insertable<HistorialFlowData> custom({
    Expression<int>? idF,
    Expression<String>? nombreSesionF,
    Expression<DateTime>? fechaSesionF,
    Expression<DateTime>? horaInicioF,
    Expression<DateTime>? horaFinF,
    Expression<int>? internas,
    Expression<int>? externas,
    Expression<String>? tiempoSesionF,
    Expression<String>? anotacionesF,
  }) {
    return RawValuesInsertable({
      if (idF != null) 'id_f': idF,
      if (nombreSesionF != null) 'Sesión Flowtime': nombreSesionF,
      if (fechaSesionF != null) 'Fecha del Flowtime': fechaSesionF,
      if (horaInicioF != null) 'Hora del Flowtime': horaInicioF,
      if (horaFinF != null) 'Hora de finalización Flow': horaFinF,
      if (internas != null) 'Interrupciones Internas': internas,
      if (externas != null) 'Interrupciones Externas': externas,
      if (tiempoSesionF != null) 'Tiempo trabajado': tiempoSesionF,
      if (anotacionesF != null) 'Anotaciones Flowtime': anotacionesF,
    });
  }

  HistorialFlowCompanion copyWith(
      {Value<int>? idF,
      Value<String>? nombreSesionF,
      Value<DateTime>? fechaSesionF,
      Value<DateTime>? horaInicioF,
      Value<DateTime>? horaFinF,
      Value<int>? internas,
      Value<int>? externas,
      Value<String>? tiempoSesionF,
      Value<String>? anotacionesF}) {
    return HistorialFlowCompanion(
      idF: idF ?? this.idF,
      nombreSesionF: nombreSesionF ?? this.nombreSesionF,
      fechaSesionF: fechaSesionF ?? this.fechaSesionF,
      horaInicioF: horaInicioF ?? this.horaInicioF,
      horaFinF: horaFinF ?? this.horaFinF,
      internas: internas ?? this.internas,
      externas: externas ?? this.externas,
      tiempoSesionF: tiempoSesionF ?? this.tiempoSesionF,
      anotacionesF: anotacionesF ?? this.anotacionesF,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idF.present) {
      map['id_f'] = Variable<int>(idF.value);
    }
    if (nombreSesionF.present) {
      map['Sesión Flowtime'] = Variable<String>(nombreSesionF.value);
    }
    if (fechaSesionF.present) {
      map['Fecha del Flowtime'] = Variable<DateTime>(fechaSesionF.value);
    }
    if (horaInicioF.present) {
      map['Hora del Flowtime'] = Variable<DateTime>(horaInicioF.value);
    }
    if (horaFinF.present) {
      map['Hora de finalización Flow'] = Variable<DateTime>(horaFinF.value);
    }
    if (internas.present) {
      map['Interrupciones Internas'] = Variable<int>(internas.value);
    }
    if (externas.present) {
      map['Interrupciones Externas'] = Variable<int>(externas.value);
    }
    if (tiempoSesionF.present) {
      map['Tiempo trabajado'] = Variable<String>(tiempoSesionF.value);
    }
    if (anotacionesF.present) {
      map['Anotaciones Flowtime'] = Variable<String>(anotacionesF.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorialFlowCompanion(')
          ..write('idF: $idF, ')
          ..write('nombreSesionF: $nombreSesionF, ')
          ..write('fechaSesionF: $fechaSesionF, ')
          ..write('horaInicioF: $horaInicioF, ')
          ..write('horaFinF: $horaFinF, ')
          ..write('internas: $internas, ')
          ..write('externas: $externas, ')
          ..write('tiempoSesionF: $tiempoSesionF, ')
          ..write('anotacionesF: $anotacionesF')
          ..write(')'))
        .toString();
  }
}

class $ProyectoTable extends Proyecto
    with TableInfo<$ProyectoTable, ProyectoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProyectoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idProyectoMeta =
      const VerificationMeta('idProyecto');
  @override
  late final GeneratedColumn<int> idProyecto = GeneratedColumn<int>(
      'id_proyecto', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreProyectoMeta =
      const VerificationMeta('nombreProyecto');
  @override
  late final GeneratedColumn<String> nombreProyecto = GeneratedColumn<String>(
      'nombre_proyecto', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [idProyecto, nombreProyecto];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proyecto';
  @override
  VerificationContext validateIntegrity(Insertable<ProyectoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_proyecto')) {
      context.handle(
          _idProyectoMeta,
          idProyecto.isAcceptableOrUnknown(
              data['id_proyecto']!, _idProyectoMeta));
    }
    if (data.containsKey('nombre_proyecto')) {
      context.handle(
          _nombreProyectoMeta,
          nombreProyecto.isAcceptableOrUnknown(
              data['nombre_proyecto']!, _nombreProyectoMeta));
    } else if (isInserting) {
      context.missing(_nombreProyectoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idProyecto};
  @override
  ProyectoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProyectoData(
      idProyecto: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_proyecto'])!,
      nombreProyecto: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nombre_proyecto'])!,
    );
  }

  @override
  $ProyectoTable createAlias(String alias) {
    return $ProyectoTable(attachedDatabase, alias);
  }
}

class ProyectoData extends DataClass implements Insertable<ProyectoData> {
  final int idProyecto;
  final String nombreProyecto;
  const ProyectoData({required this.idProyecto, required this.nombreProyecto});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_proyecto'] = Variable<int>(idProyecto);
    map['nombre_proyecto'] = Variable<String>(nombreProyecto);
    return map;
  }

  ProyectoCompanion toCompanion(bool nullToAbsent) {
    return ProyectoCompanion(
      idProyecto: Value(idProyecto),
      nombreProyecto: Value(nombreProyecto),
    );
  }

  factory ProyectoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProyectoData(
      idProyecto: serializer.fromJson<int>(json['idProyecto']),
      nombreProyecto: serializer.fromJson<String>(json['nombreProyecto']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idProyecto': serializer.toJson<int>(idProyecto),
      'nombreProyecto': serializer.toJson<String>(nombreProyecto),
    };
  }

  ProyectoData copyWith({int? idProyecto, String? nombreProyecto}) =>
      ProyectoData(
        idProyecto: idProyecto ?? this.idProyecto,
        nombreProyecto: nombreProyecto ?? this.nombreProyecto,
      );
  @override
  String toString() {
    return (StringBuffer('ProyectoData(')
          ..write('idProyecto: $idProyecto, ')
          ..write('nombreProyecto: $nombreProyecto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idProyecto, nombreProyecto);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProyectoData &&
          other.idProyecto == this.idProyecto &&
          other.nombreProyecto == this.nombreProyecto);
}

class ProyectoCompanion extends UpdateCompanion<ProyectoData> {
  final Value<int> idProyecto;
  final Value<String> nombreProyecto;
  const ProyectoCompanion({
    this.idProyecto = const Value.absent(),
    this.nombreProyecto = const Value.absent(),
  });
  ProyectoCompanion.insert({
    this.idProyecto = const Value.absent(),
    required String nombreProyecto,
  }) : nombreProyecto = Value(nombreProyecto);
  static Insertable<ProyectoData> custom({
    Expression<int>? idProyecto,
    Expression<String>? nombreProyecto,
  }) {
    return RawValuesInsertable({
      if (idProyecto != null) 'id_proyecto': idProyecto,
      if (nombreProyecto != null) 'nombre_proyecto': nombreProyecto,
    });
  }

  ProyectoCompanion copyWith(
      {Value<int>? idProyecto, Value<String>? nombreProyecto}) {
    return ProyectoCompanion(
      idProyecto: idProyecto ?? this.idProyecto,
      nombreProyecto: nombreProyecto ?? this.nombreProyecto,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idProyecto.present) {
      map['id_proyecto'] = Variable<int>(idProyecto.value);
    }
    if (nombreProyecto.present) {
      map['nombre_proyecto'] = Variable<String>(nombreProyecto.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProyectoCompanion(')
          ..write('idProyecto: $idProyecto, ')
          ..write('nombreProyecto: $nombreProyecto')
          ..write(')'))
        .toString();
  }
}

class $TareaTable extends Tarea with TableInfo<$TareaTable, TareaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idTareaMeta =
      const VerificationMeta('idTarea');
  @override
  late final GeneratedColumn<int> idTarea = GeneratedColumn<int>(
      'id_tarea', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idProyectoMeta =
      const VerificationMeta('idProyecto');
  @override
  late final GeneratedColumn<int> idProyecto = GeneratedColumn<int>(
      'id_proyecto', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _nombreTareaMeta =
      const VerificationMeta('nombreTarea');
  @override
  late final GeneratedColumn<String> nombreTarea = GeneratedColumn<String>(
      'nombre_tarea', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urgenciaMeta =
      const VerificationMeta('urgencia');
  @override
  late final GeneratedColumn<int> urgencia = GeneratedColumn<int>(
      'urgencia', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completadaMeta =
      const VerificationMeta('completada');
  @override
  late final GeneratedColumn<bool> completada = GeneratedColumn<bool>(
      'completada', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completada" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [idTarea, idProyecto, nombreTarea, urgencia, descripcion, completada];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarea';
  @override
  VerificationContext validateIntegrity(Insertable<TareaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_tarea')) {
      context.handle(_idTareaMeta,
          idTarea.isAcceptableOrUnknown(data['id_tarea']!, _idTareaMeta));
    }
    if (data.containsKey('id_proyecto')) {
      context.handle(
          _idProyectoMeta,
          idProyecto.isAcceptableOrUnknown(
              data['id_proyecto']!, _idProyectoMeta));
    } else if (isInserting) {
      context.missing(_idProyectoMeta);
    }
    if (data.containsKey('nombre_tarea')) {
      context.handle(
          _nombreTareaMeta,
          nombreTarea.isAcceptableOrUnknown(
              data['nombre_tarea']!, _nombreTareaMeta));
    } else if (isInserting) {
      context.missing(_nombreTareaMeta);
    }
    if (data.containsKey('urgencia')) {
      context.handle(_urgenciaMeta,
          urgencia.isAcceptableOrUnknown(data['urgencia']!, _urgenciaMeta));
    } else if (isInserting) {
      context.missing(_urgenciaMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('completada')) {
      context.handle(
          _completadaMeta,
          completada.isAcceptableOrUnknown(
              data['completada']!, _completadaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idTarea};
  @override
  TareaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TareaData(
      idTarea: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_tarea'])!,
      idProyecto: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_proyecto'])!,
      nombreTarea: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre_tarea'])!,
      urgencia: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}urgencia'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      completada: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completada'])!,
    );
  }

  @override
  $TareaTable createAlias(String alias) {
    return $TareaTable(attachedDatabase, alias);
  }
}

class TareaData extends DataClass implements Insertable<TareaData> {
  final int idTarea;
  final int idProyecto;
  final String nombreTarea;
  final int urgencia;
  final String descripcion;
  final bool completada;
  const TareaData(
      {required this.idTarea,
      required this.idProyecto,
      required this.nombreTarea,
      required this.urgencia,
      required this.descripcion,
      required this.completada});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_tarea'] = Variable<int>(idTarea);
    map['id_proyecto'] = Variable<int>(idProyecto);
    map['nombre_tarea'] = Variable<String>(nombreTarea);
    map['urgencia'] = Variable<int>(urgencia);
    map['descripcion'] = Variable<String>(descripcion);
    map['completada'] = Variable<bool>(completada);
    return map;
  }

  TareaCompanion toCompanion(bool nullToAbsent) {
    return TareaCompanion(
      idTarea: Value(idTarea),
      idProyecto: Value(idProyecto),
      nombreTarea: Value(nombreTarea),
      urgencia: Value(urgencia),
      descripcion: Value(descripcion),
      completada: Value(completada),
    );
  }

  factory TareaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TareaData(
      idTarea: serializer.fromJson<int>(json['idTarea']),
      idProyecto: serializer.fromJson<int>(json['idProyecto']),
      nombreTarea: serializer.fromJson<String>(json['nombreTarea']),
      urgencia: serializer.fromJson<int>(json['urgencia']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      completada: serializer.fromJson<bool>(json['completada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idTarea': serializer.toJson<int>(idTarea),
      'idProyecto': serializer.toJson<int>(idProyecto),
      'nombreTarea': serializer.toJson<String>(nombreTarea),
      'urgencia': serializer.toJson<int>(urgencia),
      'descripcion': serializer.toJson<String>(descripcion),
      'completada': serializer.toJson<bool>(completada),
    };
  }

  TareaData copyWith(
          {int? idTarea,
          int? idProyecto,
          String? nombreTarea,
          int? urgencia,
          String? descripcion,
          bool? completada}) =>
      TareaData(
        idTarea: idTarea ?? this.idTarea,
        idProyecto: idProyecto ?? this.idProyecto,
        nombreTarea: nombreTarea ?? this.nombreTarea,
        urgencia: urgencia ?? this.urgencia,
        descripcion: descripcion ?? this.descripcion,
        completada: completada ?? this.completada,
      );
  @override
  String toString() {
    return (StringBuffer('TareaData(')
          ..write('idTarea: $idTarea, ')
          ..write('idProyecto: $idProyecto, ')
          ..write('nombreTarea: $nombreTarea, ')
          ..write('urgencia: $urgencia, ')
          ..write('descripcion: $descripcion, ')
          ..write('completada: $completada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      idTarea, idProyecto, nombreTarea, urgencia, descripcion, completada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TareaData &&
          other.idTarea == this.idTarea &&
          other.idProyecto == this.idProyecto &&
          other.nombreTarea == this.nombreTarea &&
          other.urgencia == this.urgencia &&
          other.descripcion == this.descripcion &&
          other.completada == this.completada);
}

class TareaCompanion extends UpdateCompanion<TareaData> {
  final Value<int> idTarea;
  final Value<int> idProyecto;
  final Value<String> nombreTarea;
  final Value<int> urgencia;
  final Value<String> descripcion;
  final Value<bool> completada;
  const TareaCompanion({
    this.idTarea = const Value.absent(),
    this.idProyecto = const Value.absent(),
    this.nombreTarea = const Value.absent(),
    this.urgencia = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.completada = const Value.absent(),
  });
  TareaCompanion.insert({
    this.idTarea = const Value.absent(),
    required int idProyecto,
    required String nombreTarea,
    required int urgencia,
    required String descripcion,
    this.completada = const Value.absent(),
  })  : idProyecto = Value(idProyecto),
        nombreTarea = Value(nombreTarea),
        urgencia = Value(urgencia),
        descripcion = Value(descripcion);
  static Insertable<TareaData> custom({
    Expression<int>? idTarea,
    Expression<int>? idProyecto,
    Expression<String>? nombreTarea,
    Expression<int>? urgencia,
    Expression<String>? descripcion,
    Expression<bool>? completada,
  }) {
    return RawValuesInsertable({
      if (idTarea != null) 'id_tarea': idTarea,
      if (idProyecto != null) 'id_proyecto': idProyecto,
      if (nombreTarea != null) 'nombre_tarea': nombreTarea,
      if (urgencia != null) 'urgencia': urgencia,
      if (descripcion != null) 'descripcion': descripcion,
      if (completada != null) 'completada': completada,
    });
  }

  TareaCompanion copyWith(
      {Value<int>? idTarea,
      Value<int>? idProyecto,
      Value<String>? nombreTarea,
      Value<int>? urgencia,
      Value<String>? descripcion,
      Value<bool>? completada}) {
    return TareaCompanion(
      idTarea: idTarea ?? this.idTarea,
      idProyecto: idProyecto ?? this.idProyecto,
      nombreTarea: nombreTarea ?? this.nombreTarea,
      urgencia: urgencia ?? this.urgencia,
      descripcion: descripcion ?? this.descripcion,
      completada: completada ?? this.completada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idTarea.present) {
      map['id_tarea'] = Variable<int>(idTarea.value);
    }
    if (idProyecto.present) {
      map['id_proyecto'] = Variable<int>(idProyecto.value);
    }
    if (nombreTarea.present) {
      map['nombre_tarea'] = Variable<String>(nombreTarea.value);
    }
    if (urgencia.present) {
      map['urgencia'] = Variable<int>(urgencia.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (completada.present) {
      map['completada'] = Variable<bool>(completada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareaCompanion(')
          ..write('idTarea: $idTarea, ')
          ..write('idProyecto: $idProyecto, ')
          ..write('nombreTarea: $nombreTarea, ')
          ..write('urgencia: $urgencia, ')
          ..write('descripcion: $descripcion, ')
          ..write('completada: $completada')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $HistorialPomTable historialPom = $HistorialPomTable(this);
  late final $HistorialFlowTable historialFlow = $HistorialFlowTable(this);
  late final $ProyectoTable proyecto = $ProyectoTable(this);
  late final $TareaTable tarea = $TareaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [historialPom, historialFlow, proyecto, tarea];
}