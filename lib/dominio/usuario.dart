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

  // Função para atualizar o nome
  void atualizarNome(String novoNome) {
    nome = novoNome;
  }

  // Função para atualizar o email
  void atualizarEmail(String novoEmail) {
    email = novoEmail;
  }

  // Função para atualizar o telefone
  void atualizarTelefone(String novoTelefone) {
    telefone = novoTelefone;
  }

  // Função para atualizar a senha
  void atualizarSenha(String novaSenha) {
    senha = novaSenha;
  }

  // Função para verificar se a senha é válida
  bool verificarSenha(String senhaTentativa) {
    return senha == senhaTentativa;
  }

  // Função para converter o objeto Usuario em um Map (útil para JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'telefone': telefone,
    };
  }

  // Função para criar um objeto Usuario a partir de um Map (útil para JSON)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      telefone: map['telefone'],
    );
  }

  // Função para exibir detalhes do usuário
  String exibirDetalhes() {
    return 'Usuário: $nome, Email: $email, Telefone: $telefone';
  }

}
