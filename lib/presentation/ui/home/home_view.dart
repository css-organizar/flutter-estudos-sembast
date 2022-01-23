import 'package:flutter/material.dart';
import 'package:flutter_estudos_sembast/infrastructure/dal/sembast/dao/pessoa_dao.dart';
import 'package:flutter_estudos_sembast/infrastructure/dal/sembast/entities/pessoa_entity.dart';

class HomeView extends StatefulWidget {
  final String title = 'HomeView';

  const HomeView({Key? key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    PessoaDao pessoaDao = PessoaDao();
                    await pessoaDao.clear();
                  },
                  child: Text('Clear'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    PessoaDao pessoaDao = PessoaDao();
                    PessoaEntity pessoa = PessoaEntity(20, 'claudney', '', 38, 27999677326);
                    await pessoaDao.insert(pessoa);
                    var itens = await pessoaDao.getAll();
                    int i = 0;
                    for (var x in itens!) {
                      i++;
                      print('Pessoa[$i]: ${x.toJson()}');
                    }
                  },
                  child: Text('Add'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    PessoaEntity? pessoa;
                    pessoa = await PessoaDao().getById(17);
                    print(pessoa?.toJson());
                    // pessoa.nome = 'Claudney - ${DateTime.now().toIso8601String()}';
                    // await PessoaDao().update(pessoa);
                    // pessoa = await PessoaDao().getById(25);
                    // print(pessoa.toJson());
                  },
                  child: Text('getById'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    PessoaEntity? pessoa;
                    pessoa = await PessoaDao().getByName('claudney');
                    print(pessoa?.toJson());
                    // pessoa.nome = 'Claudney - ${DateTime.now().toIso8601String()}';
                    // await PessoaDao().update(pessoa);
                    // pessoa = await PessoaDao().getById(25);
                    // print(pessoa.toJson());
                  },
                  child: Text('getByNome'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    var lista = await PessoaDao().getAll();
                    for (var pessoa in lista!) {
                      print(pessoa.toJson());
                    }
                  },
                  child: Text('getAll'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
