import 'dart:io';

import 'package:agenda_contato_flutter/modelo/Contato.dart';
import 'package:flutter/material.dart';

class ContatoScreen extends StatefulWidget {
  final Contato contato;

  //construtor para passar contato da pagina
  ContatoScreen({this.contato});

  @override
  _ContatoScreenState createState() => _ContatoScreenState();
}

class _ContatoScreenState extends State<ContatoScreen> {
  //copia do contato gravado no banco
  Contato _contatoEditando;
  bool _editando = false;

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contato == null) {
      _contatoEditando = Contato();
    } else {
      _contatoEditando = Contato.mapParaContato(
        widget.contato.contatoParaMapa(),
      );
      _nomeController.text = _contatoEditando.nome;
      _emailController.text = _contatoEditando.email;
      _telefoneController.text = _contatoEditando.telefone.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_contatoEditando.nome ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
        onPressed: (){

        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _contatoEditando.imagem != null ? FileImage(File(_contatoEditando.imagem)) :AssetImage("img/images.png")
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: "Nome"
              ),
              onChanged: (valor){
                _editando = true;
                setState(() {
                  _contatoEditando.nome = valor;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: "E-mail"
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (valor){
                _editando = true;
                _contatoEditando.email = valor;
              },
            ),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(
                  labelText: "Telefone"
              ),
              keyboardType: TextInputType.phone,
              onChanged: (valor){
                _editando = true;
                _contatoEditando.telefone = valor;
              },
            ),
          ],
        ),
      ),
    );
  }
}
