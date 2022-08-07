

import 'package:cobrinha/pages/ajuda.dart';
import 'package:cobrinha/pages/modo_page.dart';
import 'package:cobrinha/theme.dart';
import 'package:cobrinha/widgets/logo.dart';
import 'package:cobrinha/widgets/recordes.dart';
import 'package:cobrinha/widgets/start_button.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? preferences;

  AdRequest? adRequest;
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {
        
      });
    });

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

  Future<void> initializePreference() async{
    this.preferences = await SharedPreferences.getInstance();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Logo(),
          StartButton(title: 'Iniciar Jogo', 
          color: cobrinhaTheme.color, 
          action: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ModoPage()));
          }
          ),
          StartButton(title: 'Ajuda', 
          color: cobrinhaTheme.color, 
          action: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Ajuda()));
          }
          ),
          const SizedBox(height: 50,),
          const Recordes()
          
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