// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContractModel {
  String name;
  String age;
  String state;
  String id;
  String walletAddress;

  String model;
  String manufacturer;
  String plate;
  String yearVehicle;

  late double premium;
  late String accepted;

  ContractModel(
    this.name,
    this.age,
    this.state,
    this.id,
    this.walletAddress,
    this.model,
    this.manufacturer,
    this.plate,
    this.yearVehicle,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dataNascimanto': age,
      'estado': state,
      'cnh': id,
      'walletAddress': walletAddress,
      'modelo': model,
      'fabricante': manufacturer,
      'placa': plate,
      'anoVeiculo': yearVehicle,
      // 'premio': premium,
      // 'isAccepted': accepted,
    };
  }

  factory ContractModel.fromMap(Map<String, dynamic> map) {
    return ContractModel(
      map['name'] as String,
      map['idade'] as String,
      map['estado'] as String,
      map['cpf'] as String,
      map['walletAddress'] as String,
      map['modelo'] as String,
      map['fabricante'] as String,
      map['placa'] as String,
      map['anoVeiculo'] as String,
      // map['premio'] as double,
      // map['isAccepted'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContractModel.fromJson(String source) =>
      ContractModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
