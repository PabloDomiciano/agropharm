import 'package:flutter/material.dart';
import 'package:pharm_application/dominio/cadastro_medicamento.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Farmácia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Definindo a tela inicial
      home: CadastroMedicamentoScreen(),
    );
  }
}
