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
                  width: 80,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: XCommon),
                const Text(
                  "nolocker",
                  style: TextStyle(color: kNeutral, fontSize: 30),
                ),
                const SizedBox(
                  height: XLarge,
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(
                  height: XCommon,
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: XCommon,
                ),
                ElevatedButton(
                    onPressed: () => Modular.to.pushNamed('/simulate'),
                    child: const Text('entrar')),
              ]),
        ),
      ),
    );
  }
}
