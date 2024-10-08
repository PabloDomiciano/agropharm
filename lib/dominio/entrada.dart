import 'package:pharm_application/dominio/medicamento.dart';

class Entrada {
  late dynamic id;
  late dynamic medicamento_id;
  late int quantidade_comprada;
  late DateTime data_de_entrada;
  Medicamento? medicamento;

  Entrada({
    required this.id,
    required this.medicamento_id,
    required this.quantidade_comprada,
    required this.data_de_entrada,
    this.medicamento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicamento_id': medicamento_id,
      'quantidade_comprada': quantidade_comprada,
      'data_de_entrada': data_de_entrada.toIso8601String(),
    };
  }

  factory Entrada.fromMap(Map<String, dynamic> map,
      {Medicamento? medicamento}) {
    return Entrada(
      id: map['id'],
      medicamento_id: map['medicamento_id'],
      quantidade_comprada: map['quantidade_comprada'],
      data_de_entrada: DateTime.parse(map['data_de_entrada']),
      medicamento: medicamento,
    );
  }

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

  String obterDescricaoCompleta() {
    return 'ID: $id, Medicamento: ${medicamento?.nome ?? 'Desconhecido'}, Quantidade Comprada: $quantidade_comprada, Data de Entrada: ${data_de_entrada.toLocal()}';
  }
}
