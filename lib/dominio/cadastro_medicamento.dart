import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharm_application/db_helper.dart';
import 'package:pharm_application/dominio/medicamento.dart';

class CadastroMedicamentoScreen extends StatefulWidget {
  @override
  _CadastroMedicamentoScreenState createState() =>
      _CadastroMedicamentoScreenState();
}

class _CadastroMedicamentoScreenState extends State<CadastroMedicamentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dbHelper = MedicamentoDB();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();
  final TextEditingController quantidadeMinimaController =
      TextEditingController();

  DateTime? _dataDeCompra;
  DateTime? _dataDeValidade;

  // Função para salvar o medicamento
  Future<void> _salvarMedicamento() async {
    if (_formKey.currentState!.validate()) {
      // Cria o objeto Medicamento
      Medicamento medicamento = Medicamento(
        id: null, // O banco de dados gerará o ID automaticamente
        nome: nomeController.text,
        quantidade: int.parse(quantidadeController.text),
        data_de_compra: _dataDeCompra!,
        data_de_validade: _dataDeValidade!,
        quantidade_minima: int.parse(quantidadeMinimaController.text),
      );

      // Salvar no banco de dados
      await _dbHelper.insertMedicamento(medicamento);
      print("Medicamento salvo com sucesso!");

      // Limpar os campos após salvar
      nomeController.clear();
      quantidadeController.clear();
      quantidadeMinimaController.clear();
      setState(() {
        _dataDeCompra = null;
        _dataDeValidade = null;
      });
    }
  }

  // Função para selecionar a data
  Future<void> _selectDate(BuildContext context, bool isCompra) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        if (isCompra) {
          _dataDeCompra = picked;
        } else {
          _dataDeValidade = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Medicamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nome do Medicamento
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome do Medicamento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do medicamento';
                  }
                  return null;
                },
              ),
              // Quantidade
              TextFormField(
                controller: quantidadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade';
                  }
                  return null;
                },
              ),
              // Quantidade Mínima
              TextFormField(
                controller: quantidadeMinimaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantidade Mínima'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade mínima';
                  }
                  return null;
                },
              ),
              // Data de Compra
              Row(
                children: [
                  Text(
                    _dataDeCompra == null
                        ? 'Data de Compra: Não selecionada'
                        : 'Data de Compra: ${DateFormat('dd/MM/yyyy').format(_dataDeCompra!)}',
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                ],
              ),
              // Data de Validade
              Row(
                children: [
                  Text(
                    _dataDeValidade == null
                        ? 'Data de Validade: Não selecionada'
                        : 'Data de Validade: ${DateFormat('dd/MM/yyyy').format(_dataDeValidade!)}',
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Botão Salvar
              ElevatedButton(
                onPressed: _salvarMedicamento,
                child: Text('Salvar Medicamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
