// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'models.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class FocusDB {
  static final FocusDB instance = FocusDB._init();

  static Database? _database;

  FocusDB._init();

  final String historialPom = 'historialPom';
  final String historialFlow = 'historialFlow';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('focus.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    final database = await databaseFactoryFfi.openDatabase(path);

    if (!await _isTableExists(database, historialPom)) {
      await _onConfigureDB(database);
    }

    return database;
  }

  Future<bool> _isTableExists(Database db, String tableName) async {
    final result = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type="table" AND name="$tableName"');
    return result.isNotEmpty;
  }

  Future _onConfigureDB(Database database) async {
    await database.execute('''
      CREATE TABLE $historialPom(
        idP INTEGER PRIMARY KEY,
        nombreSesionP TEXT,
        fechaSesionP INTEGER,
        horaInicioP INTEGER,
        horaFinP INTEGER,
        pomodoros INTEGER,
        rondas INTEGER,
        tiempoSesionP TEXT,
        anotacionesP TEXT
      )
    ''');
    await database.execute('''
      CREATE TABLE $historialFlow(
        idF INTEGER PRIMARY KEY AUTOINCREMENT,     
        nombreSesionF TEXT,
        fechaSesionF INTEGER,
        horaInicioF INTEGER,
        horaFinF INTEGER,
        internas INTEGER,
        externas INTEGER,
        tiempoSesionF INTEGER,
        anotacionesF TEXT
      )
    ''');
  }

  int dateToTimeStamp(DateTime date) {
    return date.millisecondsSinceEpoch;
  }

  DateTime timeStampToDate(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  Future<void> insertHistPom(RegistroPom item) async {
    final db = await instance.database;
    await db.insert(
      historialPom,
      item.toMapP(),
    );
  }
}
