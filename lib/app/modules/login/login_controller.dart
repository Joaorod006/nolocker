import 'package:flutter_modular/flutter_modular.dart';
import 'package:signals/signals.dart';

class LoginController {
  Signal<String> username = signal('vazio');
  Signal<String> password = signal('');

  void login() {
    Modular.to.pushNamed('/simulate');
  }
}
