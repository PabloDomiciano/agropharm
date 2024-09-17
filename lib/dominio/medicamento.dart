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


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'data_de_compra':
          data_de_compra.toIso8601String(), 
      'data_de_validade':
          data_de_validade.toIso8601String(), 
      'quantidade_minima': quantidade_minima,
    };
  }


  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      id: map['id'],
      nome: map['nome'],
      quantidade: map['quantidade'],
      data_de_compra: DateTime.parse(map['data_de_compra']),
      data_de_validade: DateTime.parse(map['data_de_validade']),
      quantidade_minima: map['quantidade_minima'],
    );
  }
}
