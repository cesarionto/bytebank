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
        body: FormularioTransferencia(),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controllerNumeroConta,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                    labelText: 'Numero da Conta', hintText: '0000-0 00.000-0'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controllerValor,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    labelText: 'Valor',
                    hintText: '0.00'),
              ),
            ),
            RaisedButton(
              onPressed: () {
                final double? valor = double.tryParse(_controllerValor.text);
                final String numeroConta =
                    _controllerNumeroConta.text.toString();
                if (valor != null && numeroConta != null) {
                  final Transferencia _transferencia =
                      Transferencia(valor, numeroConta);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Transferencia Criada! '+'Valor: ' +
                            _transferencia.valor.toString() +
                            ' Numero da Conta: ' +
                            _transferencia.numeroConta.toString())),
                  );
                  debugPrint("Transferencia Salva");
                }
              },
              child: Text('Confirmar'),
            )
          ],
        ));
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencias'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(1500, '1085-5 15.946-8')),
          ItemTransferencia(Transferencia(3000, '1085-5 15.946-8')),
          ItemTransferencia(Transferencia(1550, '1085-5 15.946-8')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
        subtitle: Text(_transferencia.numeroConta),
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
