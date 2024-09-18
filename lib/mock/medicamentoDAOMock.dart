import 'package:pharm_application/dominio/medicamento.dart';
import 'package:pharm_application/idao/MedicamentoIDAO.dart';

class MedicamentoDAOMock implements MedicamentoIDAO {
  final List<Medicamento> _medicamentos = [];

  @override
  Future<void> inserirMedicamento(Medicamento medicamento) async {
    _medicamentos.add(medicamento);
  }

  @override
  Future<List<Medicamento>> listarMedicamentos() async {
    return _medicamentos;
  }

  @override
  Future<void> atualizarMedicamento(Medicamento medicamento) async {
    final index = _medicamentos.indexWhere((m) => m.id == medicamento.id);
    if (index != -1) {
      _medicamentos[index] = medicamento;
    }
  }

  @override
  Future<void> deletarMedicamento(int id) async {
    _medicamentos.removeWhere((m) => m.id == id);
  }
}
