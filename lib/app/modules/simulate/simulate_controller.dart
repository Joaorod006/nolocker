import 'package:nolocker/app/models/contract_model.dart';
import 'package:nolocker/app/modules/metamask.dart';

import 'package:nolocker/app/services/contract/contract_service.dart';
import 'package:signals/signals.dart';

class SimulateController {
  final ContractService contractService = ContractService();
  final MetaMaskProvider metaMaskProvider = MetaMaskProvider();
  final Signal<bool> isCreating = signal<bool>(false);

  Signal<ContractModel> contract = signal(ContractModel('1111', '2222', '3333',
      '44444', '4444', '4444', '44444', '44444', '4444'));

  Future<void> innitContract() async {
    isCreating.value = true;
    await metaMaskProvider.connect();
    contract.value.walletAddress = metaMaskProvider.currentAddress.value;
    // print(contract.value.walletAddress);
    await contractService.createContract(contract.value.toJson())
        // .then((value) {
        //   print('then');
        //   isCreating.value = true;
        //   contract.value.premium = value!.data.premio;
        // });
        ;
  }
}
