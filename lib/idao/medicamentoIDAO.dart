import 'package:pharm_application/dominio/medicamento.dart';

abstract class MedicamentoIDAO {
  Future<void> inserirMedicamento(Medicamento medicamento);


  Future<List<Medicamento>> listarMedicamentos();


  Future<void> atualizarMedicamento(Medicamento medicamento);


  Future<void> deletarMedicamento(int id);
}