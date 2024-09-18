import 'package:pharm_application/dominio/entrada.dart';
import 'package:pharm_application/idao/entradaIDAO.dart';

class EntradaDAOMock implements EntradaIDAO {
  final List<Entrada> _entradas =
      []; // Lista para armazenar entradas em memória

  @override
  Future<int> insertEntrada(Entrada entrada) async {
    // Adiciona a entrada na lista e retorna o ID fictício
    _entradas.add(entrada);
    return entrada.id as int; // Assume que id é um int
  }

  @override
  Future<List<Entrada>> getEntradas() async {
    // Retorna a lista de entradas
    return List.from(_entradas);
  }

  @override
  Future<int> updateEntrada(Entrada entrada) async {
    // Encontra a entrada pelo ID e atualiza os dados
    final index = _entradas.indexWhere((e) => e.id == entrada.id);
    if (index != -1) {
      _entradas[index] = entrada;
      return 1; // Retorna 1 indicando sucesso
    }
    return 0; // Retorna 0 indicando que a entrada não foi encontrada
  }

  @override
  Future<int> deleteEntrada(int id) async {
    // Remove a entrada com o ID especificado
    final index = _entradas.indexWhere((e) => e.id == id);
    if (index != -1) {
      _entradas.removeAt(index);
      return 1; // Retorna 1 indicando sucesso
    }
    return 0; // Retorna 0 indicando que a entrada não foi encontrada
  }

  @override
  Future<Entrada?> getEntradaById(int id) async {
    // Retorna a entrada com o ID especificado, ou null se não for encontrada
    return _entradas.firstWhere(
      (e) => e.id == id,
      orElse: () => Entrada(
        id: -1, // Usar um valor fictício para id quando não encontrado
        medicamento_id: -1, // Usar um valor fictício para medicamento_id
        quantidade_comprada: 0, // Valor fictício para quantidade_comprada
        data_de_entrada: DateTime.now(), // Valor fictício para data_de_entrada
      ),
    );
  }
}
