import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nolocker/app/modules/metamask.dart';
import 'package:nolocker/app/modules/simulate/simulate_controller.dart';
import 'package:nolocker/app/shared/utils/constantes.dart';

class SimulatePage extends StatefulWidget {
  const SimulatePage({super.key});

  @override
  State<SimulatePage> createState() => _SimulatePageState();
}

class _SimulatePageState extends State<SimulatePage> {
  MetaMaskProvider metaMaskProvider = Modular.get<MetaMaskProvider>();
  SimulateController simulateController = Modular.get<SimulateController>();

  int _index = 0;

  // final TextEditingController _Controller = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _cnhController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  final TextEditingController _fabricanteController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _anoVeiculoController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.addListener(() {
      simulateController.contract.value.name =
          _nomeController.text.toLowerCase();
    });
    _idadeController.addListener(() {
      simulateController.contract.value.age =
          _idadeController.text.toLowerCase();
    });
    _cnhController.addListener(() {
      simulateController.contract.value.age = _cnhController.text.toLowerCase();
    });
    _estadoController.addListener(() {
      simulateController.contract.value.age =
          _estadoController.text.toLowerCase();
    });
    _fabricanteController.addListener(() {
      simulateController.contract.value.age =
          _fabricanteController.text.toLowerCase();
    });
    _modeloController.addListener(() {
      simulateController.contract.value.age =
          _modeloController.text.toLowerCase();
    });
    _anoVeiculoController.addListener(() {
      simulateController.contract.value.age =
          _anoVeiculoController.text.toLowerCase();
    });
    _placaController.addListener(() {
      simulateController.contract.value.age =
          _placaController.text.toLowerCase();
    });
  }

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
              onStepContinue: () async {
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
                      Text('Dados do Condutor'),
                    ],
                  ),
                  content: Column(
                    children: [
                      FormField(
                        controller: _nomeController,
                        title: 'Insira seu nome:',
                        label: 'Nome',
                      ),
                      FormField(
                        controller: _idadeController,
                        title: 'Sua idade:',
                        label: 'Idade',
                      ),
                      FormField(
                        controller: _estadoController,
                        title: 'Seu estado:',
                        label: 'Estado(US)',
                      ),
                      FormField(
                        controller: _cnhController,
                        title: 'Seu CNH:',
                        label: 'CNH',
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
                    children: [
                      FormField(
                        controller: _fabricanteController,
                        title: 'Fabricante do veiculo:',
                        label: 'Fabricante',
                      ),
                      FormField(
                        controller: _modeloController,
                        title: 'Modelo do veiculo:',
                        label: 'Modelo',
                      ),
                      FormField(
                        controller: _anoVeiculoController,
                        title: 'Ano do veiculo:',
                        label: 'Ano',
                      ),
                      FormField(
                        controller: _placaController,
                        title: 'Placa do veiculo:',
                        label: 'Placa',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  print('object clicked');
                  simulateController.innitContract();
                },
                child: Text('gerar'))
          ],
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({
    super.key,
    required TextEditingController controller,
    required this.title,
    required this.label,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: XSmall,
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(label: Text(label)),
          ),
          SizedBox(
            height: XCommon,
          ),
        ],
      ),
    );
  }
}
