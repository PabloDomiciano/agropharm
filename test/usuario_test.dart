import 'package:flutter_test/flutter_test.dart';
import '../lib/dominio/usuario.dart';

void main() {
  group('Usuario Testes', () {
    // Configura um usuário inicial para os testes
    late Usuario usuario;

    setUp(() {
      usuario = Usuario(
        id: 1,
        nome: 'Pablo Henrique',
        email: 'pablo@example.com',
        senha: '12345',
        telefone: '999999999',
      );
    });

    test('Deve atualizar o nome do usuário', () {
      usuario.atualizarNome('Carlos Alberto');
      expect(usuario.nome, 'Carlos Alberto');
    });

    test('Deve atualizar o email do usuário', () {
      usuario.atualizarEmail('carlos@example.com');
      expect(usuario.email, 'carlos@example.com');
    });

    test('Deve atualizar o telefone do usuário', () {
      usuario.atualizarTelefone('888888888');
      expect(usuario.telefone, '888888888');
    });

    test('Deve atualizar a senha do usuário', () {
      usuario.atualizarSenha('novaSenha123');
      expect(usuario.senha, 'novaSenha123');
    });

    test('Deve verificar se a senha está correta', () {
      expect(usuario.verificarSenha('12345'), isTrue);
    });

    test('Deve verificar se a senha está incorreta', () {
      expect(usuario.verificarSenha('senhaErrada'), isFalse);
    });

    test('Deve converter o objeto Usuario para Map corretamente', () {
      Map<String, dynamic> usuarioMap = usuario.toMap();
      expect(usuarioMap['id'], 1);
      expect(usuarioMap['nome'], 'Pablo Henrique');
      expect(usuarioMap['email'], 'pablo@example.com');
      expect(usuarioMap['senha'], '12345');
      expect(usuarioMap['telefone'], '999999999');
    });

    test('Deve criar um objeto Usuario a partir de um Map', () {
      Map<String, dynamic> usuarioMap = {
        'id': 2,
        'nome': 'Ana Souza',
        'email': 'ana@example.com',
        'senha': 'senha123',
        'telefone': '777777777',
      };

      Usuario novoUsuario = Usuario.fromMap(usuarioMap);

      expect(novoUsuario.id, 2);
      expect(novoUsuario.nome, 'Ana Souza');
      expect(novoUsuario.email, 'ana@example.com');
      expect(novoUsuario.senha, 'senha123');
      expect(novoUsuario.telefone, '777777777');
    });

    test('Deve exibir os detalhes do usuário corretamente', () {
      String detalhes = usuario.exibirDetalhes();
      expect(detalhes, 'Usuário: Pablo Henrique, Email: pablo@example.com, Telefone: 999999999');
    });
  });
}
