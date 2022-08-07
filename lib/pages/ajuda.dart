import 'package:cobrinha/theme.dart';
import 'package:flutter/material.dart';


import 'dart:io' show Platform;

import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ajuda extends StatefulWidget {
  const Ajuda({Key? key}) : super(key: key);

  @override
  State<Ajuda> createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  final List<String> _helps = [
    'Bem vido ao Snack Game da SuetamSoft',
    'primeiro você precisa escolher um modo de jogo',
    'No modo normal o jogo da Cobra é mais fácil pois a cobra só tem que coletar um tipo de alimento',
    'No modo Desafiante é o modo mais difícil pois terá varios alimentos que não poderão ser coletados',
    'Verde: será a comida a ser coletada!',
    'Vermelho: Perde 3 Pontos!',
    'Azul: Perde 1 ponto!',
    'Amarelo: Perdera pontos aleatorio de acordo com seu ponto!',
    'Rosa: sua Pontuação sera zerada!',
    'Branca: Você ganha pontos aleatorio ou perde todos os pontos!',
    
  ];

  AdRequest? adRequest;
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    String bannerId = Platform.isAndroid
        ? "ca-app-pub-2028996810271423/6622453719"
        : "ca-app-pub-3940256099942544/2934735716";

    adRequest = const AdRequest(
      nonPersonalizedAds: false,
    );

    BannerAdListener bannerAdListener = BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
      },
      onAdClosed: (ad) {
        bannerAd!.load();
      },
      onAdFailedToLoad: (ad, error) {
        bannerAd!.load();
      },
    );
    bannerAd = BannerAd(
      size: AdSize.leaderboard,
      adUnitId: bannerId,
      listener: bannerAdListener,
      request: adRequest!,
    );
    bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            AppBar(
              title: const Text('Ajuda'),
            ),
            const SizedBox(height: 1.0),
            ..._buildHelp(),
            const SizedBox(height: 1.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
              height: 38.0,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: cobrinhaTheme.color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: const Text('Bom Jogo!', style: TextStyle(fontSize: 23)),
            ),
            isLoaded
                ? SizedBox(
                    height: 52,
                    width: 370,
                    child: AdWidget(
                      ad: bannerAd!,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHelp() {
    return _helps
        .asMap()
        .entries
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              '${e.key + 1}. ${e.value}',
              style: const TextStyle(fontSize: 23),
            ),
          ),
        )
        .toList();
  }
}
