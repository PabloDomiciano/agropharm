import 'package:sqflite/sqflite.dart';
import 'package:pharm_application/dominio/medicamento.dart';
import 'package:pharm_application/idao/MedicamentoIDAO.dart';

class MedicamentoDAO implements MedicamentoIDAO {
  final Database db;

  MedicamentoDAO(this.db);

  @override
  Future<void> inserirMedicamento(Medicamento medicamento) async {
    await db.insert(
      'medicamentos',
      medicamento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Medicamento>> listarMedicamentos() async {
    final List<Map<String, dynamic>> maps = await db.query('medicamentos');

    return List.generate(maps.length, (i) {
      return Medicamento(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        quantidade: maps[i]['quantidade'],
        data_de_compra: DateTime.parse(maps[i]['data_de_compra']),
        data_de_validade: DateTime.parse(maps[i]['data_de_validade']),
        quantidade_minima: maps[i]['quantidade_minima'],
      );
    });
  }

  @override
  Future<void> atualizarMedicamento(Medicamento medicamento) async {
    await db.update(
      'medicamentos',
      medicamento.toMap(),
      where: 'id = ?',
      whereArgs: [medicamento.id],
    );
  }

  @override
  Future<void> deletarMedicamento(int id) async {
    await db.delete(
      'medicamentos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
