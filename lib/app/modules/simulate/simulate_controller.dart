import 'package:flutter_modular/flutter_modular.dart';
import 'package:nolocker/app/models/contract_model.dart';
import 'package:nolocker/app/modules/metamask.dart';

import 'package:nolocker/app/services/contract/contract_service.dart';
import 'package:signals/signals.dart';

class SimulateController {
  final ContractService contractService = ContractService();
  final MetaMaskProvider metaMaskProvider = MetaMaskProvider();
  final Signal<bool> isCreating = signal<bool>(false);

  final Signal<ContractModel> contract =
      signal(ContractModel('', '', '', '', '', '', '', '', ''));

  Future<void> innitContract() async {
    isCreating.value = true;
    await metaMaskProvider.connect();
    contract.value.walletAddress = metaMaskProvider.currentAddress.value;
    final resjsonData =
        await contractService.createContract(contract.value.toJson());
    contract.value.premium = resjsonData!.data['premio'];
  }

  Future<void> acceptContract() async {
    await contractService.acceptContract(contract.value.walletAddress, true);
    Modular.to.navigate('/home');
  }
}
