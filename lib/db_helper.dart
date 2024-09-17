import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pharm_application/dominio/entrada.dart';
import 'package:pharm_application/dominio/medicamento.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicialização do banco de dados
  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'pharm_application.db'),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE medicamentos(id INTEGER PRIMARY KEY, nome TEXT, quantidade INTEGER, data_de_compra TEXT, data_de_validade TEXT, quantidade_minima INTEGER)");
        db.execute(
            "CREATE TABLE entradas(id INTEGER PRIMARY KEY, medicamento_id INTEGER, quantidade_comprada INTEGER, data_de_entrada TEXT, FOREIGN KEY(medicamento_id) REFERENCES medicamentos(id))");
      },
      version: 1,
    );
  }
}

// CRUD para a tabela de Medicamentos
class MedicamentoDB {
  final DBHelper dbHelper = DBHelper();

  Future<void> insertMedicamento(Medicamento medicamento) async {
    try {
      final db = await dbHelper.database;
      await db.insert(
        'medicamentos',
        medicamento.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Erro ao inserir medicamento: $e");
    }
  }

  Future<Medicamento?> getMedicamento(int id) async {
    try {
      final db = await dbHelper.database;
      final maps = await db.query(
        'medicamentos',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Medicamento.fromMap(maps.first);
      }
    } catch (e) {
      print("Erro ao obter medicamento: $e");
    }
    return null;
  }

  Future<List<Medicamento>> getMedicamentos() async {
    try {
      final db = await dbHelper.database;
      final maps = await db.query('medicamentos');
      return maps.map((map) => Medicamento.fromMap(map)).toList();
    } catch (e) {
      print("Erro ao obter lista de medicamentos: $e");
      return [];
    }
  }

  Future<void> updateMedicamento(Medicamento medicamento) async {
    try {
      final db = await dbHelper.database;
      await db.update(
        'medicamentos',
        medicamento.toMap(),
        where: "id = ?",
        whereArgs: [medicamento.id],
      );
    } catch (e) {
      print("Erro ao atualizar medicamento: $e");
    }
  }

  Future<void> deleteMedicamento(int id) async {
    try {
      final db = await dbHelper.database;
      await db.delete(
        'medicamentos',
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print("Erro ao deletar medicamento: $e");
    }
  }
}

// CRUD para a tabela de Entradas
class EntradaDB {
  final DBHelper dbHelper = DBHelper();

  Future<void> insertEntrada(Entrada entrada) async {
    try {
      final db = await dbHelper.database;
      await db.insert(
        'entradas',
        entrada.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Erro ao inserir entrada: $e");
    }
  }

  Future<Entrada?> getEntrada(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'entradas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      int medicamentoId = maps.first['medicamento_id'] as int;
      final medicamentoDB = MedicamentoDB();
      final medicamento = await medicamentoDB.getMedicamento(medicamentoId);

      return Entrada.fromMap(maps.first, medicamento: medicamento);
    }
    return null;
  }

  Future<List<Entrada>> getEntradas() async {
    try {
      final db = await dbHelper.database;
      final maps = await db.query('entradas');

      List<Entrada> entradas = [];
      final medicamentoDB = MedicamentoDB();

      for (var map in maps) {
        int medicamentoId = map['medicamento_id'] as int;

        final medicamento = await medicamentoDB.getMedicamento(medicamentoId);
        entradas.add(Entrada.fromMap(map, medicamento: medicamento));
      }
      return entradas;
    } catch (e) {
      print("Erro ao obter lista de entradas: $e");
      return [];
    }
  }

  Future<void> updateEntrada(Entrada entrada) async {
    try {
      final db = await dbHelper.database;
      await db.update(
        'entradas',
        entrada.toMap(),
        where: "id = ?",
        whereArgs: [entrada.id],
      );
    } catch (e) {
      print("Erro ao atualizar entrada: $e");
    }
  }

  Future<void> deleteEntrada(int id) async {
    try {
      final db = await dbHelper.database;
      await db.delete(
        'entradas',
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print("Erro ao deletar entrada: $e");
    }
  }
}
