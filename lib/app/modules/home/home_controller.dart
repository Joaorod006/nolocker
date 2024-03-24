import 'dart:convert';

import 'package:nolocker/app/models/NFT_model.dart';
import 'package:nolocker/app/modules/metamask.dart';
import 'package:nolocker/app/services/contract/contract_service.dart';
import 'package:nolocker/app/services/token/tokenService.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

class HomeController {
  MetaMaskProvider metaMaskProvider = MetaMaskProvider();
  TokenService tokenService = TokenService();
  ListSignal<NFTModel> allNfts = ListSignal<NFTModel>([
    NFTModel(id: "...", nome: "...", ipfsHash: "..."),
  ]);

  Future<void> getNFTs() async {
    final walletAddress = metaMaskProvider.currentAddress.value;
    if (walletAddress != '') {
      final jsonData = await tokenService.getNFTs();
      final List<dynamic> decodedJson =
          jsonDecode(jsonData!.data) as List<dynamic>;

      final List<NFTModel> nftModels =
          decodedJson.map((dynamic json) => NFTModel.fromJson(json)).toList();
      allNfts.set(nftModels);
    }
  }
}
