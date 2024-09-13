class Medicamentos {
  late dynamic id;
  late String nome;
  late String dosagem;
  late String uMedida;
  late DateTime compra;
  late DateTime aplicacao;
  late DateTime validade;
  late String _status;

  Medicamentos({
    required this.id,
    required this.nome,
    required this.dosagem,
    required this.uMedida,
    required this.compra,
    required this.aplicacao,
    required this.validade,
    required String status,
  }) {
    this.status = status;
  }

  String get status => _status;

  set status(String status) {
    if (status != 'A' && status != 'I') {
      throw Exception('Status deve ser "A" ou "I".');
    }
    _status = status;
  }

  void eNomeNaoVazio() {
    if (nome.isEmpty) throw Exception("Nome não pode ser vazio.");
  }

  void eDosagemNaoVazio() {
    if (dosagem.isEmpty) throw Exception("Dosagem não pode ser vazio.");
  }

  void eUmedidaNaoVazio() {
    if (uMedida.isEmpty)
      throw Exception("Unidade de medida não pode ser vazio.");
  }

  void eDataCompra() {
    if (compra == null) throw Exception('Data de compra não pode ser nula.');
  }

  void eDataAplicacao() {
    if (aplicacao == null)
      throw Exception('Data de aplicação não pode ser nula.');
  }

  void eDataValidade() {
    if (validade == null)
      throw Exception('Data de validade não pode ser nula.');
  }

  void verificaValidade() {
    DateTime dataAtual = DateTime.now();

    int diasParaVencer = validade.difference(dataAtual).inDays;

    if (diasParaVencer <= 45 && diasParaVencer > 30) {
      throw Exception('Medicamento irá vencer em 45 dias');
    } else if (diasParaVencer <= 30 && diasParaVencer > 15) {
      throw Exception('Medicamento irá vencer em 30 dias');
    } else if (diasParaVencer <= 15) {
      throw Exception('Medicamento irá vencer em 15 dias');
    } else {
      print('Medicamento válido por mais de 45 dias');
    }
  }

  void eVerificaStatus() {
    if (_status != 'A' && _status != 'I') {
      throw Exception('Status deve ser "A" ou "I".');
    }
  }
}
