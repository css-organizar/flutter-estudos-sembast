import 'package:flutter_estudos_sembast/infrastructure/dal/sembast/contracts/sembast_dao_contract.dart';
import 'package:flutter_estudos_sembast/infrastructure/dal/sembast/entities/pessoa_entity.dart';
import 'package:flutter_estudos_sembast/infrastructure/service/sembast/sembast_connection.dart';
import 'package:sembast/sembast.dart';

class PessoaDao implements SembastDaoContract<PessoaEntity> {
  String get _storeName => 'pessoa';
  StoreRef get _store => intMapStoreFactory.store(_storeName);

  Future<Database> get _db async {
    return await SembastConnection.instance.database;
  }

  @override
  Future<void> clear() async {
    await _store.delete(await _db);
  }

  @override
  Future<void> insert(PessoaEntity pessoa) async {
    var existeRegistro = await getByName(pessoa.nome!);

    if (existeRegistro == null) {
      pessoa.id = await _store.add(
        await _db,
        pessoa.toMap(),
      );
    }

    await update(pessoa);
  }

  @override
  Future<void> insertAll(List<PessoaEntity> entities) async {
    final maps = entities.map((entity) => entity.toMap()).toList();
    await _store.addAll(await _db, maps);
  }

  @override
  Future<void> update(PessoaEntity pessoa) async {
    final finder = Finder(
      filter: Filter.byKey(
        pessoa.id,
      ),
    );

    await _store.update(
      await _db,
      pessoa.toMap(),
      finder: finder,
    );
  }

  @override
  Future<void> updateAll(List<PessoaEntity> entities) async {
    for (PessoaEntity entity in entities) {
      await update(entity);
    }
  }

  @override
  Future<void> delete(PessoaEntity pessoa) async {
    final finder = Finder(
      filter: Filter.byKey(
        pessoa.id,
      ),
    );

    await _store.delete(
      await _db,
      finder: finder,
    );
  }

  @override
  Future<void> deleteAll(List<PessoaEntity> entities) async {
    final finder = Finder(
      filter: Filter.or(
        entities.map((entity) => Filter.equals('nome', entity.nome)).toList(),
      ),
    );

    await _store.delete(await _db, finder: finder);
  }

  @override
  Future<List<PessoaEntity>?> getAll() async {
    final recordSnapshot = await _store.find(await _db);

    return recordSnapshot.map(
      (snapshot) {
        final pessoa = PessoaEntity.fromMap(
          snapshot.value,
        );
        return pessoa;
      },
    ).toList();
  }

  Future<PessoaEntity?> getByName(String value) async {
    PessoaEntity? returnPessoaEntity;

    final finder = Finder(
      filter: Filter.equals(
        'nome',
        value,
      ),
    );

    final recordSnapshot = await _store.find(
      await _db,
      finder: finder,
    );

    if (recordSnapshot.isNotEmpty) {
      returnPessoaEntity = PessoaEntity.fromMap(recordSnapshot[0].value);
    }

    return returnPessoaEntity;
  }

  Future<PessoaEntity?> getById(int value) async {
    PessoaEntity? returnPessoaEntity;

    final finder = Finder(
      filter: Filter.equals(
        'id',
        value,
      ),
    );

    final recordSnapshot = await _store.find(
      await _db,
      finder: finder,
    );

    if (recordSnapshot.isNotEmpty) {
      returnPessoaEntity = PessoaEntity.fromMap(recordSnapshot[0].value);
    }

    return returnPessoaEntity;
  }

  Future<void> deleteById(int id) async {
    final finder = Finder(
      filter: Filter.byKey(id),
    );

    await _store.delete(
      await _db,
      finder: finder,
    );
  }
}
