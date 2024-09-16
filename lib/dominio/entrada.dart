import 'dart:ffi';

class Entrada {
  late dynamic id;
  late dynamic medicamento_id;
  late int quantidade_comprada;
  late DateTime data_de_entrada;

  Entrada({
    required this.id,
    required this.medicamento_id,
    required this.quantidade_comprada,
    required this.data_de_entrada,
  });

  void atualizarQuantidade(int novaQuantidade) {
    if (novaQuantidade >= 0) {
      quantidade_comprada = novaQuantidade;
    } else {
      throw ArgumentError('Quantidade não pode ser negativa');
    }
  }

  String obterDescricao() {
    return 'ID: $id, Medicamento ID: $medicamento_id, Quantidade Comprada: $quantidade_comprada, Data de Entrada: ${data_de_entrada.toLocal()}';
  }
}
