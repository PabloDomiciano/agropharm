class Medicamento {
  late dynamic id;
  late String nome;
  late int quantidade;
  late DateTime data_de_compra;
  late DateTime data_de_validade;
  late int quantidade_minima;

  Medicamento({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.data_de_compra,
    required this.data_de_validade,
    required this.quantidade_minima,
  });

  bool isVencido() {
    return DateTime.now().isAfter(data_de_validade);
  }

  bool isEstoqueBaixo() {
    return quantidade < quantidade_minima;
  }

  void atualizarQuantidade(int quantidadeAdicional) {
    if (quantidade + quantidadeAdicional >= 0) {
      quantidade += quantidadeAdicional;
    } else {
      throw Exception("Quantidade não pode ser negativa");
    }
  }
}
