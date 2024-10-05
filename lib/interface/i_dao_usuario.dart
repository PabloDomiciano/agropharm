import 'package:pharm_application/dto/dto_usuario.dart';

abstract class IDAOUsuario {
  Future<DTOUsuario> salvar(DTOUsuario dto);
  Future<DTOUsuario> alterar(DTOUsuario dto);
  Future<DTOUsuario> consultarPorId(int id);
  Future<List<DTOUsuario>> consultar();
}
