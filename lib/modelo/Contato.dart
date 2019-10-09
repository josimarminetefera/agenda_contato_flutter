import 'package:agenda_contato_flutter/helpers/contato_helper.dart';

class Contato {
  int id;
  String nome;
  String email;
  String telefone;
  String imagem;

  Contato();

  //para armazenar os dados no celular
  Contato.mapParaContato(Map map) {
    id = map[idColuna];
    nome = map[nomeColuna];
    email = map[emailColuna];
    telefone = map[telefoneColuna];
    imagem = map[imagemColuna];
  }

  Map contatoParaMapa() {
    Map<String, dynamic> map = {
      nomeColuna: nome,
      emailColuna: email,
      telefoneColuna: telefone,
      imagemColuna: imagem,
    };
    if (id != null) {
      map[imagemColuna] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contato: id: $id - nome: $nome - email:$email - telefone: $telefone - imagem: $imagem";
  }
}
