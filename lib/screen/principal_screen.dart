import 'dart:io';

import 'package:agenda_contato_flutter/helpers/contato_helper.dart';
import 'package:agenda_contato_flutter/modelo/Contato.dart';
import 'package:agenda_contato_flutter/screen/contato_screen.dart';
import 'package:flutter/material.dart';

class PrincipalScreen extends StatefulWidget {
  @override
  _PrincipalScreenState createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  ContatoHelper contatoHelper = ContatoHelper();

  List<Contato> contatos = List();

  @override
  void initState() {
    super.initState();
    print("Sistema iniciado");
//    Contato contato = Contato();
//    contato.nome = "Josimar Doido";
//    contato.email = "josima@fdsfdsfdsfds";
//    contato.telefone = "3333456456456";
//    contato.imagem = null;
//    contatoHelper.salvarContato(contato);

    contatoHelper.listarTodosContatos().then((valor) {
      print(valor);
    });

    //obter todos contatos
    contatoHelper.listarTodosContatos().then((listaContatos) {
      setState(() {
        contatos = listaContatos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contatos"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        //botao no canto inferior
        floatingActionButton: FloatingActionButton(
          onPressed: _mostrarContatoScreen,
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contatos.length,
          //tem que passar a função que vai me passar o item da minha posição
          itemBuilder: (context, index) {
            return _criarCard(context, index);
          },
        ));
  }

  Widget _criarCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _mostrarContatoScreen(contato: contatos[index]);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: (contatos[index].imagem != null) ? FileImage(File(contatos[index].imagem)) : AssetImage("img/images.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contatos[index].nome ?? "",
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contatos[index].email ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      contatos[index].telefone ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarContatoScreen({Contato contato}) async {
    final retorno = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContatoScreen(contato: contato)),
    );
  }
}
