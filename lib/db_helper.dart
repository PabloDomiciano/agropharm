import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pharm_application/dominio/entrada.dart';


class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'entrada.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE entradas(id INTEGER PRIMARY KEY, medicamento_id INTEGER, quantidade_comprada INTEGER, data_de_entrada TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertEntrada(Entrada entrada) async {
    final db = await database;
    await db.insert(
      'entradas',
      entrada.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Entrada>> getEntradas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('entradas');

    return List.generate(maps.length, (i) {
      return Entrada(
        id: maps[i]['id'],
        medicamento_id: maps[i]['medicamento_id'],
        quantidade_comprada: maps[i]['quantidade_comprada'],
        data_de_entrada: DateTime.parse(maps[i]['data_de_entrada']),
      );
    });
  }

  Future<void> updateEntrada(Entrada entrada) async {
    final db = await database;
    await db.update(
      'entradas',
      entrada.toMap(),
      where: "id = ?",
      whereArgs: [entrada.id],
    );
  }

  Future<void> deleteEntrada(int id) async {
    final db = await database;
    await db.delete(
      'entradas',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
