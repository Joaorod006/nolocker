import 'package:flutter_modular/flutter_modular.dart';
import 'package:nolocker/app/modules/home/home_controller.dart';
import 'package:nolocker/app/modules/home/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
