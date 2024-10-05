import 'package:pharm_application/banco/sqlite/conexao.dart';
import 'package:pharm_application/dto/dto_usuario.dart';
import 'package:pharm_application/interface/i_dao_usuario.dart';
import 'package:sqflite/sqflite.dart';

class DAOUsuario implements IDAOUsuario {
  late Database _db;
  final sqlInserir = '''
    INSERT INTO professor (nome, email, senha, telefone)
    VALUES (?,?,?,?,?)
  ''';
  final sqlAlterar = '''
    UPDATE professor SET nome=?, email=?, senha=?, telefone=?, 
    WHERE id = ?
  ''';
  final sqlConsultarPorId = '''
    SELECT * FROM professor WHERE id = ?;
  ''';
  final sqlConsultar = '''
    SELECT * FROM professor;
  ''';

@override
Future<DTOUsuario> salvar(DTOUsuario dto) async {
  if (dto.nome.isEmpty || dto.email.isEmpty || dto.senha.isEmpty || dto.telefone.isEmpty) {
    throw Exception('Todos os campos devem ser preenchidos');
  }
  
  if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(dto.email)) {
    throw Exception('Formato de email inválido');
  }
  _db = await Conexao.iniciar();
  int id = await _db.rawInsert(sqlInserir, [dto.nome, dto.email, dto.senha, dto.telefone]);
  dto.id = id;
  return dto;
}

  @override
  Future<DTOUsuario> alterar(DTOUsuario dto) async {
    _db = await Conexao.iniciar();
    await _db
        .rawUpdate(sqlAlterar, [dto.nome, dto.email, dto.senha, dto.telefone]);
    return dto;
  }

  @override
  Future<DTOUsuario> consultarPorId(int id) async {
    _db = await Conexao.iniciar();
    var resultado = (await _db.rawQuery(sqlConsultarPorId, [id])).first;
    DTOUsuario usuario = DTOUsuario(
      id: resultado['id'],
      nome: resultado['nome'].toString(),
      email: resultado['email'].toString(),
      senha: resultado['senha'].toString(),
      telefone: resultado['telefone'].toString(),
    );
    return usuario;
  }

  @override
  Future<List<DTOUsuario>> consultar() async {
    _db = await Conexao.iniciar();
    var resultado = await _db.rawQuery(sqlConsultar);
    List<DTOUsuario> usuarios = List.generate(resultado.length, (i) {
      var linha = resultado[i];
      return DTOUsuario(
        id: linha['id'],
        nome: linha['nome'].toString(),
        email: linha['email'].toString(),
        senha: linha['senha'].toString(),
        telefone: linha['telefone'].toString(),
      );
    });
    return usuarios;
  }
}
