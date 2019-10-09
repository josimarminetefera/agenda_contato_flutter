import 'package:agenda_contato_flutter/modelo/Contato.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tabela = "CONTATOS";
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

  factory ContatoHelper() => _instance;

  ContatoHelper.internal();

  //banco de dados da classe
  Database _dbPrincipal;

  Future<Database> get db async {
    if (_dbPrincipal != null) {
      print("db já existe");
      //já tem uma instancia de banco criada
      return _dbPrincipal;
    } else {
      print("db não existe");
      //executa a primeira vez
      _dbPrincipal = await iniciarDb();
      return _dbPrincipal;
    }
  }

  Future<Database> iniciarDb() async {
    print("iniciarDb");
    final dataBasePath = await getDatabasesPath();
    final caminho = join(dataBasePath, 'contatos.db');

    //abrir o banco de dados
    return await openDatabase(caminho, version: 1, onCreate: (Database db, int versaoAtual) async {
      await db.execute(
        "CREATE TABLE $tabela ("
        "$idColuna INTEGER PRIMARY KEY, "
        "$nomeColuna TEXT, "
        "$emailColuna TEXT, "
        "$telefoneColuna TEXT, "
        "$imagemColuna TEXT"
        ")",
      );
    });
  }

  Future<Contato> salvarContato(Contato contato) async {
    print("salvarContato");
    //pegar o banco de dados
    Database database = await db;
    contato.id = await database.insert(tabela, contato.contatoParaMapa());
    return contato;
  }

  Future<Contato> pegarContato(int id) async {
    //pegar o banco de dados
    Database database = await db;
    List<Map> lista = await database.query(
      tabela,
      columns: [
        idColuna,
        nomeColuna,
        emailColuna,
        telefoneColuna,
        imagemColuna,
      ],
      where: "$idColuna = ?",
      whereArgs: [id],
    );
    if (lista.length > 0) {
      return Contato.mapParaContato(lista.first);
    } else {
      return null;
    }
  }

  Future<int> deletarContato(int id) async {
    //pegar o banco de dados
    Database database = await db;
    return await database.delete(
      tabela,
      where: "$idColuna = ?",
      whereArgs: [id],
    );
  }

  Future<int> atualizarContato(Contato contato) async {
    //pegar o banco de dados
    Database database = await db;
    return await database.update(
      tabela,
      contato.contatoParaMapa(),
      where: "$idColuna = ?",
      whereArgs: [contato.id],
    );
  }

  Future<List> listarTodosContatos() async {
    print("listarTodosContatos");
    //pegar o banco de dados
    Database database = await db;
    List listaMap = await database.rawQuery("SELECT * FROM $tabela");
    List<Contato> listaContatos = new List();
    for (Map linha in listaMap) {
      listaContatos.add(Contato.mapParaContato(linha));
    }
    return listaContatos;
  }

  Future<int> quantidadeDeContatos() async {
    //pegar o banco de dados
    Database database = await db;
    return Sqflite.firstIntValue(await database.rawQuery("SELECT COUNT(1) FROM $tabela"));
  }

  Future fecharBancoDados() async {
    //pegar o banco de dados
    Database database = await db;
    database.close();
  }
}
