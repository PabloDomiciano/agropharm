import 'package:flutter_test/flutter_test.dart';
import '../lib/dominio/animal.dart';

void main() {
  group('Teste da classe Animal', () {
    test('Verifica a descrição completa do animal', () {
      final animal = Animal(
        id: 1,
        nome: 'Leão',
        tipo: 'Mamífero',
      );

      expect(animal.obterDescricao(),
          equals('Nome: Leão, Tipo: Mamífero'));
    });
  });
}
