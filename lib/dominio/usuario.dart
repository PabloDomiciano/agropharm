class Usuario {
  late dynamic id;
  late String nome;
  late String email;
  late String senha;
  late String telefone;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.telefone,
  });

  bool validarUsuario() {
    if (nome.isEmpty || email.isEmpty || senha.isEmpty || telefone.isEmpty) {
      return false;
    }

    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      return false;
    }
   
    if (!RegExp(r"^\d{9,}$").hasMatch(telefone)) {
      return false;
    }
    return true;
  }
}
