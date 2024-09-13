import 'package:flutter_test/flutter_test.dart';
import '../lib/dominio/medicamentos.dart';

void main() {
  group('Medicamentos', () {
    late Medicamentos medicamento;

    setUp(() {
      medicamento = Medicamentos(
        id: 1,
        nome: 'Paracetamol',
        dosagem: '500mg',
        uMedida: 'mg',
        compra: DateTime(2023, 5, 1),
        aplicacao: DateTime(2023, 5, 2),
        validade: DateTime(2024, 4, 30),
        status: 'A',
      );
    });

    test('Nome não pode ser vazio', () {
      medicamento.nome = '';
      expect(() => medicamento.eNomeNaoVazio(), throwsException);
    });

    test('Dosagem não pode ser vazio', () {
      medicamento.dosagem = '';
      expect(() => medicamento.eDosagemNaoVazio(), throwsException);
    });

    test('Unidade de medida não pode ser vazio', () {
      medicamento.uMedida = '';
      expect(() => medicamento.eUmedidaNaoVazio(), throwsException);
    });

    test('Data de compra não pode ser inválida', () {
      medicamento.compra = DateTime(2023, 5, 1); 
      expect(() => medicamento.eDataCompra(), returnsNormally);
    });

    test('Data de aplicação não pode ser inválida', () {
      medicamento.aplicacao = DateTime(2023, 5, 2); 
      expect(() => medicamento.eDataAplicacao(), returnsNormally);
    });

    test('Data de validade não pode ser inválida', () {
      medicamento.validade = DateTime(2024, 11, 30); 
      expect(() => medicamento.eDataValidade(), returnsNormally);
    });

    test('Verifica validade', () {
      medicamento.validade = DateTime.now().add(Duration(days: 20));
      expect(() => medicamento.verificaValidade(), throwsException);

 
      medicamento.validade = DateTime.now().add(Duration(days: 50));
      expect(() => medicamento.verificaValidade(),
      prints('Medicamento válido por mais de 45 dias'));

      medicamento.validade = DateTime.now().add(Duration(days: 10));
      expect(() => medicamento.verificaValidade(), throwsException);
    });

    test('Status válido', () {
      medicamento.status = 'A';
      expect(medicamento.status, 'A');

      medicamento.status = 'I';
      expect(medicamento.status, 'I');
    });

    test('Status inválido deve lançar exceção', () {
      expect(() {
        medicamento.status = 'X'; 
      }, throwsException);
    });

    test('Verifica status válido', () {
      expect(() => medicamento.eVerificaStatus(), returnsNormally);
    });
  });
}
