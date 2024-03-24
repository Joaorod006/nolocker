class NFTModel {
  final String id;
  final String nome;
  final String ipfsHash;

  NFTModel({
    required this.id,
    required this.nome,
    required this.ipfsHash,
  });

  factory NFTModel.fromJson(Map<String, dynamic> json) => NFTModel(
        id: json["id"] as String,
        nome: json["nome"] as String,
        ipfsHash: json["ipfsHash"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "ipfsHash": ipfsHash,
      };
}
