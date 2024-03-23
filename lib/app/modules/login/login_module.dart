import 'package:flutter_modular/flutter_modular.dart';
import 'package:nolocker/app/modules/login/login_controller.dart';
import 'package:nolocker/app/modules/simulate/simulate_page.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(LoginController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
    r.child('/simulate', child: (context) => const SimulatePage());

    // r.module('/home', module: HomeModule());
  }
}
