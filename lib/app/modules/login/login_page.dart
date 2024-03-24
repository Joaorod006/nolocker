import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nolocker/app/modules/login/login_controller.dart';
import 'package:nolocker/app/shared/utils/constantes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Modular.get<LoginController>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      loginController.username.value = _usernameController.text.toLowerCase();
    });
    _passwordController.addListener(() {
      loginController.username.value = _passwordController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: XLarge),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/LOGO.png',
                  width: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: XCommon),
                const Text(
                  "nolocker",
                  style: TextStyle(color: kNeutral, fontSize: 26),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  padding: EdgeInsets.all(XCommon),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kNeutralSoft,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(XLarge),
                        child: Image.asset(
                          'assets/images/FOX.png',
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => loginController.login(),
                          child: const Text('Conectar com Metamask')),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
