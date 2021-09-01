import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ByteBanckApp());
}

class ByteBanckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criando Transferencia'),
        ),
        body: Column(
          children: [
            Editor(
              controlador: _controllerNumeroConta,
              dica: '0000-0',
              rotulo: 'Numero da Conta',
            ),
            Editor(
              controlador: _controllerValor,
              dica: '0.00',
              rotulo: 'Valor',
              icon: Icons.monetization_on,
              tipoTeclado: TextInputType.number,
            ),
            RaisedButton(
              onPressed: () => _criaTransferencia(context),
              child: Text('Confirmar'),
            )
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final double? valor = double.tryParse(_controllerValor.text);
    final String? numeroConta = _controllerNumeroConta.text.toString();
    if (valor != null && numeroConta != null) {
      final Transferencia _transferencia = Transferencia(valor, numeroConta);
      Navigator.pop(context, _transferencia);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icon;
  final TextInputType? tipoTeclado;

  Editor(
      {this.controlador, this.rotulo, this.dica, this.icon, this.tipoTeclado});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        keyboardType: tipoTeclado,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icon != null ? Icon(icon) : null,
            labelText: '$rotulo',
            hintText: '$dica'),
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencias'),
      ),
      body: ListView.builder(
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
        itemCount: widget._transferencias.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return FormularioTransferencia();
            }),
          ).then((transferencia) {

            widget._transferencias.add(transferencia);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
        leading: Icon(Icons.monetization_on),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final String numeroConta;

  Transferencia(this.valor, this.numeroConta);
}
