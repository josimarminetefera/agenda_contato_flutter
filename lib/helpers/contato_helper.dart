import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tabelaContato = "CONTATO";
final String idColuna = "ID";
final String nomeColuna = "NOME";
final String emailColuna = "EMAIL";
final String telefoneColuna = "TELEFONE";
final String imagemColuna = "IMAGEM";

//vai conter apenas um objeto no codigo inteiro
class ContatoHelper {
  //static = variavel apenas uma da classe
  //final = nao alteravel
  //_instance é um objeto da propria classe
  static final ContatoHelper _instance = ContatoHelper.internal();

  //contacto helper. isntance voce tem a instancia do contato
  factory ContatoHelper() => _instance;

  //construtor interno
  ContatoHelper.internal();

  //banco de dados da classe
  Database _db;

  Future<Database> get db async {
    if (db != null) {
      return _db;
    } else {
      //executa a primeira vez
      _db = await iniciarDb();
      return _db;
    }
  }

  Future<Database> iniciarDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, 'contato.db');

    //abrir o banco de dados
    return await openDatabase(path, version: 1, onCreate: (Database db, int versaoAtual) async {
      await db.execute("CREATE TABLE $tabelaContato ($idColuna INTEGER PRIMARY KEY, $nomeColuna TEXT, $emailColuna TEXT, $telefoneColuna TEXT, $imagemColuna TEXT)");
    });
  }
}

class Contato {
  int id;
  String nome;
  String email;
  String telefone;
  String imagem;

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
