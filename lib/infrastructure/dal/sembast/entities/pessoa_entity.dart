import 'dart:convert';

import 'package:flutter_estudos_sembast/infrastructure/dal/sembast/contracts/sembast_dao_entity.dart';

class PessoaEntity implements SembastDaoEntity {
  int? id;
  String? nome;
  String? email;
  int? idade;
  int? telefone;

  PessoaEntity(
    this.id,
    this.nome,
    this.email,
    this.idade,
    this.telefone,
  );

  @override
  String get identifierName => 'id';
  @override
  get identifier => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'idade': idade,
      'telefone': telefone,
    };
  }

  factory PessoaEntity.fromMap(Map<String, dynamic> map) {
    return PessoaEntity(
      map['id']?.toInt(),
      map['nome'],
      map['email'],
      map['idade']?.toInt(),
      map['telefone']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PessoaEntity.fromJson(String source) => PessoaEntity.fromMap(json.decode(source));
}
