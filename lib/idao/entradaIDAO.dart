import 'package:pharm_application/dominio/entrada.dart';

abstract class EntradaIDAO {
  Future<int> insertEntrada(Entrada entrada);


  Future<List<Entrada>> getEntradas();


  Future<int> updateEntrada(Entrada entrada);


  Future<int> deleteEntrada(int id);

  
  Future<Entrada?> getEntradaById(int id);
}
