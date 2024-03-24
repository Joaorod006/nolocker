import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nolocker/app/modules/metamask.dart';
import 'package:nolocker/app/shared/utils/constantes.dart';

class SimulatePage extends StatefulWidget {
  const SimulatePage({super.key});

  @override
  State<SimulatePage> createState() => _SimulatePageState();
}

class _SimulatePageState extends State<SimulatePage> {
  MetaMaskProvider metaMaskProvider = Modular.get<MetaMaskProvider>();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: XLarge,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: XLarge),
              child: Column(
                children: [
                  Text(
                    'Vamos simular seu seguro!',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                      'Preencha os campos abaixo pra podermos calcular o valor')
                ],
              ),
            ),
            SizedBox(
              height: XCommon,
            ),
            Stepper(
              physics: ScrollPhysics(),
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (_index <= 0) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              steps: <Step>[
                Step(
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        child: Icon(
                          Icons.contact_page_outlined,
                          color: kNeutral,
                        ),
                        backgroundColor: kNeutralSoft,
                      ),
                      SizedBox(
                        width: XCommon,
                      ),
                      Text('Dados do Veiculo'),
                    ],
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () => metaMaskProvider.connect(),
                          child: Text("connect")),
                      Text("Seu nome completo:"),
                      SizedBox(
                        height: XSmall,
                      ),
                      TextField(
                        decoration:
                            InputDecoration(label: Text('Nome completo')),
                      ),
                      SizedBox(
                        height: XCommon,
                      ),
                    ],
                  ),
                ),
                Step(
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        child: Icon(
                          Icons.directions_car_filled_outlined,
                          color: kNeutral,
                        ),
                        backgroundColor: kNeutralSoft,
                      ),
                      SizedBox(
                        width: XCommon,
                      ),
                      Text('Dados do Veiculo'),
                    ],
                  ),
                  content: Column(
                    children: [],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        SizedBox(
          height: XCommon,
        ),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        SizedBox(
          height: XCommon,
        ),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        SizedBox(
          height: XCommon,
        ),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        SizedBox(
          height: XCommon,
        ),
      ],
    );
  }
}

// Nome
// Data nascimento,
// CPF,

// Modelo,
// Ano de fabricaçao
// Localidade,
// Tipo do veiculo,
