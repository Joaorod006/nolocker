import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

class MetaMaskProvider {
  static const operatingChain = 4;

  Signal<String> currentAddress = signal('');

  Signal<int> currentChain = signal(-1);

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain.value == operatingChain;

  bool get isConnected => isEnabled && currentAddress.value.isNotEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress.value = accs.first;

      currentChain.value = await ethereum!.getChainId();
    }
  }

  clear() {
    currentAddress.value = '';
    currentChain.value = -1;
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }
}
