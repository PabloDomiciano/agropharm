import 'package:sqflite/sqflite.dart';
import 'package:pharm_application/dominio/entrada.dart';
import 'package:pharm_application/db_helper.dart';
import 'package:pharm_application/idao/entradaIDAO.dart';

class EntradaDAO implements EntradaIDAO {
  final DBHelper dbHelper = DBHelper();

  @override
  Future<int> insertEntrada(Entrada entrada) async {
    final db = await dbHelper.database;
    return await db.insert(
      'entradas',
      entrada.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Entrada>> getEntradas() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('entradas');

    return List.generate(maps.length, (i) {
      return Entrada.fromMap(maps[i]);
    });
  }

  @override
  Future<int> updateEntrada(Entrada entrada) async {
    final db = await dbHelper.database;
    return await db.update(
      'entradas',
      entrada.toMap(),
      where: 'id = ?',
      whereArgs: [entrada.id],
    );
  }

  @override
  Future<int> deleteEntrada(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'entradas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<Entrada?> getEntradaById(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'entradas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Entrada.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
