import 'package:flutter_test/flutter_test.dart';
import 'package:pharm_application/mock/entradaDAOMock.dart';
import 'package:pharm_application/dominio/entrada.dart';

void main() {
  late EntradaDAOMock entradaDAO;

  setUp(() {
    entradaDAO = EntradaDAOMock();
  });

  group('Testes de CRUD para EntradaDAOMock', () {
    test('Deve inserir uma entrada', () async {
      final entrada = Entrada(
        id: 1,
        medicamento_id: 101,
        quantidade_comprada: 50,
        data_de_entrada: DateTime.now(),
      );

      final id = await entradaDAO.insertEntrada(entrada);
      expect(id, equals(1)); // O ID deve ser igual ao valor fictício usado na implementação
    });

    test('Deve retornar todas as entradas', () async {
      final entrada1 = Entrada(
        id: 1,
        medicamento_id: 101,
        quantidade_comprada: 50,
        data_de_entrada: DateTime.now(),
      );

      final entrada2 = Entrada(
        id: 2,
        medicamento_id: 102,
        quantidade_comprada: 30,
        data_de_entrada: DateTime.now(),
      );

      await entradaDAO.insertEntrada(entrada1);
      await entradaDAO.insertEntrada(entrada2);

      final entradas = await entradaDAO.getEntradas();
      expect(entradas.length, equals(2));
      expect(entradas, contains(entrada1));
      expect(entradas, contains(entrada2));
    });

    test('Deve atualizar uma entrada', () async {
      final entrada = Entrada(
        id: 1,
        medicamento_id: 101,
        quantidade_comprada: 50,
        data_de_entrada: DateTime.now(),
      );

      await entradaDAO.insertEntrada(entrada);

      final entradaAtualizada = Entrada(
        id: 1,
        medicamento_id: 101,
        quantidade_comprada: 75,
        data_de_entrada: DateTime.now(),
      );

      final resultado = await entradaDAO.updateEntrada(entradaAtualizada);
      expect(resultado, equals(1));

      final entradaObtida = await entradaDAO.getEntradaById(1);
      expect(entradaObtida?.quantidade_comprada, equals(75));
    });


    test('Deve retornar entrada por ID', () async {
      final entrada = Entrada(
        id: 1,
        medicamento_id: 101,
        quantidade_comprada: 50,
        data_de_entrada: DateTime.now(),
      );

      await entradaDAO.insertEntrada(entrada);

      final entradaObtida = await entradaDAO.getEntradaById(1);
      expect(entradaObtida?.id, equals(1));
      expect(entradaObtida?.quantidade_comprada, equals(50));
    });
  });
}
