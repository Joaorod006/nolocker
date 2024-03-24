import 'package:flutter_modular/flutter_modular.dart';
import 'package:nolocker/app/modules/metamask.dart';
import 'package:signals/signals.dart';

class LoginController {
  MetaMaskProvider metaMaskProvider = MetaMaskProvider();
  Signal<String> username = signal('vazio');
  Signal<String> password = signal('');

  void login() async {
    await metaMaskProvider.connect();
    Modular.to.pushNamed('/simulate');
  }

  void init() {
    metaMaskProvider.init();
  }
}
