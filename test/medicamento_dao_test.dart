import 'package:flutter_test/flutter_test.dart';
import 'package:pharm_application/dominio/medicamento.dart';
import 'package:pharm_application/idao/MedicamentoIDAO.dart';
import 'package:pharm_application/mock/MedicamentoDAOMock.dart';

void main() {
  MedicamentoIDAO medicamentoIDAO = MedicamentoDAOMock();
  late Medicamento medicamentoTeste;

  setUp(() {
    medicamentoIDAO = MedicamentoDAOMock();
    
    medicamentoTeste = Medicamento(
      id: 1,
      nome: "Remédio A",
      quantidade: 10,
      data_de_compra: DateTime.now(),
      data_de_validade: DateTime.now().add(Duration(days: 365)),
      quantidade_minima: 5,
    );
  });

  test('Deve inserir um medicamento corretamente', () async {
    await medicamentoIDAO.inserirMedicamento(medicamentoTeste);
    final medicamentos = await medicamentoIDAO.listarMedicamentos();
    
    expect(medicamentos.length, 1);
    expect(medicamentos.first.nome, "Remédio A");
  });

  test('Deve atualizar um medicamento existente', () async {
    await medicamentoIDAO.inserirMedicamento(medicamentoTeste);
    
    // Atualiza o medicamento
    medicamentoTeste.quantidade = 20;
    await medicamentoIDAO.atualizarMedicamento(medicamentoTeste);
    
    final medicamentos = await medicamentoIDAO.listarMedicamentos();
    expect(medicamentos.first.quantidade, 20);
  });

  test('Deve deletar um medicamento', () async {
    await medicamentoIDAO.inserirMedicamento(medicamentoTeste);
    
    // Deleta o medicamento
    await medicamentoIDAO.deletarMedicamento(medicamentoTeste.id);
    
    final medicamentos = await medicamentoIDAO.listarMedicamentos();
    expect(medicamentos.length, 0);
  });
}
