import 'package:sqflite/sqflite.dart';
import 'package:pharm_application/dominio/entrada.dart';
import 'package:pharm_application/db_helper.dart';

class EntradaDAO {
  final DBHelper dbHelper = DBHelper();


  Future<int> insertEntrada(Entrada entrada) async {
    final db = await dbHelper.database;
    return await db.insert(
      'entradas', 
      entrada.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Entrada>> getEntradas() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('entradas');

    return List.generate(maps.length, (i) {
      return Entrada.fromMap(maps[i]);
    });
  }


  Future<int> updateEntrada(Entrada entrada) async {
    final db = await dbHelper.database;
    return await db.update(
      'entradas',
      entrada.toMap(),
      where: 'id = ?',
      whereArgs: [entrada.id],
    );
  }

 
  Future<int> deleteEntrada(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'entradas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

 
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
