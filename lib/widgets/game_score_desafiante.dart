import 'package:cobrinha/theme.dart';
import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants.dart';


import 'dart:io' show Platform;

class GameScoreDesafiante extends StatefulWidget {
  
  const GameScoreDesafiante({Key? key,}) : super(key: key);

  @override
  State<GameScoreDesafiante> createState() => _GameScoreDesafianteState();
}

class _GameScoreDesafianteState extends State<GameScoreDesafiante> {
  AdRequest? adRequest;
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
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
    

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 50),
          ],
        ),
        Text('Desafiante', style: 
          TextStyle(color: cobrinhaTheme.color, fontSize: 40),
        ),
        TextButton(
            child: const Text('Sair', style: TextStyle(fontSize: 20,color: Colors.red)),
            onPressed: () {
              isLoaded ? InterstitialAd.load(
          adUnitId: Platform.isAndroid 
          ?"ca-app-pub-2028996810271423/5309372044"
          :"ca-app-pub-3940256099942544/4411468910", 
          request: const AdRequest(), 
          adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
           interstitialAd = ad;
           interstitialAd!.show();
           Navigator.of(context).pop();
          }, onAdFailedToLoad: (error){
            debugPrint(error.message);
          }),
          ): Navigator.of(context).pop();
            }),
      ],
    );
  }
}