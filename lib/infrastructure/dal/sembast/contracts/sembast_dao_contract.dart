abstract class SembastDaoContract<T> {
  Future<void> clear() async {}
  Future<void> insert(T value) async {}
  Future<void> insertAll(List<T> entities) async {}
  Future<void> update(T value) async {}
  Future<void> updateAll(List<T> entities) async {}
  Future<void> delete(T value) async {}
  Future<void> deleteAll(List<T> entities) async {}
  Future<List<T>?> getAll() async {}
}
