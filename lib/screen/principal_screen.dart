import 'package:agenda_contato_flutter/helpers/contato_helper.dart';
import 'package:agenda_contato_flutter/modelo/Contato.dart';
import 'package:flutter/material.dart';

class PrincipalScreen extends StatefulWidget {
  @override
  _PrincipalScreenState createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {

  ContatoHelper contatoHelper = ContatoHelper();


  @override
  void initState() {
    super.initState();
    print("Sistema iniciado");
    /*Contato contato = Contato();
    contato.nome = "Josimar";
    contato.email = "josima@fdsfds";
    contato.telefone = "4545456456456";
    contato.imagem = "qualquercoisa";
    contatoHelper.salvarContato(contato);*/

    contatoHelper.listarTodosContatos().then((valor){
      print(valor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
