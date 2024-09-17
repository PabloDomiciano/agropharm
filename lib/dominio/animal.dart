class Animal {
  late dynamic id;
  late String nome;
  late String tipo;

  Animal({
    required this.id,
    required this.nome,
    required this.tipo,
  });

  String obterDescricao() {
    return 'Nome: $nome, Tipo: $tipo';
  }
}
