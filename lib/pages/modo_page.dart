
import 'dart:io' show Platform;

import 'package:cobrinha/pages/game_page_normal.dart';

import 'package:cobrinha/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants.dart';
import '../widgets/start_button.dart';
import 'game_page_desafiante.dart';

class ModoPage extends StatefulWidget {
  const ModoPage({ Key? key }) : super(key: key);

  @override
  State<ModoPage> createState() => _ModoPageState();
}

class _ModoPageState extends State<ModoPage> {

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
      appBar: AppBar(
        title: const Text('Escolha o Modo de Jogo'),
      ),
      body: Padding(padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          StartButton(title: 'Normal', 
          color: cobrinhaTheme.color,
          action: ()=> Navigator.push(
            context, MaterialPageRoute(
              builder: (BuildContext context) => 
              const GamePageNormal(),
              ),
            ),
          ),
          StartButton(title: 'Desafiante', 
          color: cobrinhaTheme.color,
          action: ()=> Navigator.push(
            context, MaterialPageRoute(
              builder: (BuildContext context) => 
              const GamePageDesafiante(),
              ),
            ),
          ),
          
        ],
      ),
      ),
      floatingActionButton: isLoaded
                ? SizedBox(
                    height: 62,
                    width: 370,
                    child: AdWidget(
                      ad: bannerAd!,
                    ),
                  )
                : const SizedBox(),
    );
  }
}