import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Transferencias'),
      ),
      body:ListaTransferencia(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add),
      ),
    ),
  ));
}


class ListaTransferencia extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTransferencia(Transferencia(1500,'1085-5 15.946-8')),
        ItemTransferencia(Transferencia(3000,'1085-5 15.946-8')),
        ItemTransferencia(Transferencia(1550,'1085-5 15.946-8')),
      ],
    );
  }
}

class ItemTransferencia extends StatelessWidget{

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

class Transferencia{

  final double valor;
  final String numeroConta;

  Transferencia(this.valor, this.numeroConta);
}