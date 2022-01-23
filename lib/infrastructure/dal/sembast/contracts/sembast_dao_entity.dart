abstract class SembastDaoEntity {
  dynamic get identifier;
  String get identifierName;

  SembastDaoEntity.fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}
