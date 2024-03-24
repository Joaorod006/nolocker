import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nolocker/app/modules/home/home_controller.dart';
import 'package:nolocker/app/shared/utils/constantes.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Modular.get<HomeController>();
  @override
  void initState() {
    super.initState();
    homeController.getNFTs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        padding: EdgeInsets.all(XSmall),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kNeutralSoft),
        child: Column(
          children: [
            Row(
              children: [],
            ),
            Watch((context) => ListView.builder(
                  itemCount: homeController.allNfts.length,
                  itemBuilder: (context, i) {
                    final nft = homeController.allNfts.value[i];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(nft.nome),
                            Spacer(),
                            Text(nft.id),
                          ],
                        )
                      ],
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
