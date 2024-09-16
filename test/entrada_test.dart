import 'package:flutter_test/flutter_test.dart';
import '../lib/dominio/entrada.dart';

void main() {
  group('Teste da classe Entrada', () {
    test('Atualiza a quantidade comprada', () {
      final entrada = Entrada(
        id: 1,
        medicamento_id: 100,
        quantidade_comprada: 50,
        data_de_entrada: DateTime.now(),
      );

      entrada.atualizarQuantidade(70);
      expect(entrada.quantidade_comprada, equals(70));

      expect(() => entrada.atualizarQuantidade(-10), throwsArgumentError);
    });

    test('Obtém a descrição da entrada', () {
      final entrada = Entrada(
        id: 1,
        medicamento_id: 100,
        quantidade_comprada: 50,
        data_de_entrada: DateTime(2024, 9, 15),
      );

      expect(
          entrada.obterDescricao(),
          equals(
              'ID: 1, Medicamento ID: 100, Quantidade Comprada: 50, Data de Entrada: 2024-09-15 00:00:00.000'));
    });
  });
}
