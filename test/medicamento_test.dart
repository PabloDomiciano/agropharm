import 'package:flutter_test/flutter_test.dart';
import '../lib/dominio/medicamento.dart';

void main() {
  group('Teste da classe Medicamento', () {
    test('Verifica se o medicamento está vencido', () {
      final medicamento = Medicamento(
        id: 1,
        nome: 'Medicamento A',
        quantidade: 10,
        data_de_compra: DateTime.now().subtract(Duration(days: 30)),
        data_de_validade: DateTime.now().subtract(Duration(days: 1)),
        quantidade_minima: 5,
      );

      expect(medicamento.isVencido(), isTrue);
    });

    test('Verifica se o estoque está baixo', () {
      final medicamento = Medicamento(
        id: 1,
        nome: 'Medicamento B',
        quantidade: 3,
        data_de_compra: DateTime.now(),
        data_de_validade: DateTime.now().add(Duration(days: 30)),
        quantidade_minima: 5,
      );

      expect(medicamento.isEstoqueBaixo(), isTrue);
    });

    test('Atualiza a quantidade do medicamento', () {
      final medicamento = Medicamento(
        id: 1,
        nome: 'Medicamento C',
        quantidade: 10,
        data_de_compra: DateTime.now(),
        data_de_validade: DateTime.now().add(Duration(days: 30)),
        quantidade_minima: 5,
      );

      medicamento.atualizarQuantidade(-3);
      expect(medicamento.quantidade, equals(7));

      medicamento.atualizarQuantidade(5);
      expect(medicamento.quantidade, equals(12));

      expect(() => medicamento.atualizarQuantidade(-20), throwsException);
    });
  });
}
