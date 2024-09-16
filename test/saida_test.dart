import 'package:flutter_test/flutter_test.dart';
import '../lib/dominio/saida.dart';

void main() {
  group('Teste da classe Saida', () {
    test('Atualiza a quantidade utilizada', () {
      final saida = Saida(
        id: 1,
        medicamento_id: 100,
        quantidade_utilizada: 30,
        data_de_saida: DateTime.now(),
        tipo_de_saida: 'Tratamento',
        animal_id: 200,
      );

      saida.atualizarQuantidadeUtilizada(40);
      expect(saida.quantidade_utilizada, equals(40));

      expect(
          () => saida.atualizarQuantidadeUtilizada(-10), throwsArgumentError);
    });

    test('Obtém a descrição da saída', () {
      final saida = Saida(
        id: 1,
        medicamento_id: 100,
        quantidade_utilizada: 30,
        data_de_saida: DateTime(2024, 9, 15),
        tipo_de_saida: 'Tratamento',
        animal_id: 200,
      );

      expect(
          saida.obterDescricao(),
          equals(
              'ID: 1, Medicamento ID: 100, Quantidade Utilizada: 30, Data de Saída: 2024-09-15 00:00:00.000, Tipo de Saída: Tratamento, Animal ID: 200'));
    });
  });
}
