import 'package:flutter/material.dart';
import 'package:pharm_application/db_helper.dart';
import 'package:pharm_application/dominio/entrada.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EntradaScreen(),
    );
  }
}

class EntradaScreen extends StatefulWidget {
  @override
  _EntradaScreenState createState() => _EntradaScreenState();
}

class _EntradaScreenState extends State<EntradaScreen> {
  final DBHelper dbHelper = DBHelper();
  List<Entrada> entradas = [];

  @override
  void initState() {
    super.initState();
    _loadEntradas();
  }

  Future<void> _loadEntradas() async {
    final allEntradas = await dbHelper.getEntradas();
    setState(() {
      entradas = allEntradas;
    });
  }

  Future<void> _addEntrada() async {
    final newEntrada = Entrada(
      id: 1, // ID gerado ou atribuído
      medicamento_id: 100,
      quantidade_comprada: 50,
      data_de_entrada: DateTime.now(),
    );
    await dbHelper.insertEntrada(newEntrada);
    _loadEntradas();
  }

  Future<void> _updateEntrada(int id) async {
    final updatedEntrada = Entrada(
      id: id,
      medicamento_id: 100,
      quantidade_comprada: 75,
      data_de_entrada: DateTime.now(),
    );
    await dbHelper.updateEntrada(updatedEntrada);
    _loadEntradas();
  }

  Future<void> _deleteEntrada(int id) async {
    await dbHelper.deleteEntrada(id);
    _loadEntradas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entradas')),
      body: ListView.builder(
        itemCount: entradas.length,
        itemBuilder: (context, index) {
          final entrada = entradas[index];
          return ListTile(
            title: Text(entrada.obterDescricao()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updateEntrada(entrada.id),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteEntrada(entrada.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addEntrada,
      ),
    );
  }
}
