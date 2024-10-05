class DTOUsuario {
  dynamic id;
  final String nome;
  final String email;
  final String senha;
  final String telefone;
  DTOUsuario(
      {this.id,
      required this.nome,
      required this.email,
      required this.senha,
      required this.telefone});
}
