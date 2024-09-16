class Saida {
  late dynamic id;
  late dynamic medicamento_id;
  late int quantidade_utilizada;
  late DateTime data_de_saida;
  late String tipo_de_saida;
  late dynamic animal_id;

  Saida({
    required this.id,
    required this.medicamento_id,
    required this.quantidade_utilizada,
    required this.data_de_saida,
    required this.tipo_de_saida,
    required this.animal_id,
  });

  void atualizarQuantidadeUtilizada(int novaQuantidade) {
    if (novaQuantidade >= 0) {
      quantidade_utilizada = novaQuantidade;
    } else {
      throw ArgumentError('Quantidade não pode ser negativa');
    }
  }

  String obterDescricao() {
    return 'ID: $id, Medicamento ID: $medicamento_id, Quantidade Utilizada: $quantidade_utilizada, Data de Saída: ${data_de_saida.toLocal()}, Tipo de Saída: $tipo_de_saida, Animal ID: $animal_id';
  }
  
}
