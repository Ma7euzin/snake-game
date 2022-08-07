
import 'dart:io' show Platform;

import 'package:cobrinha/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordesPageNormal extends StatefulWidget {
  
  @override
  State<RecordesPageNormal> createState() => _RecordesPageNormalState();
}

late List<String>? li = ['0'];

class _RecordesPageNormalState extends State<RecordesPageNormal> {
  SharedPreferences? prefs;
  AdRequest? adRequest;
  BannerAd? bannerAd;
  bool isLoaded = false;
  
  void initialize() async {
    this.prefs = await SharedPreferences.getInstance();

    li = prefs?.getStringList("highscores");

   if(li != null){
    li?.sort((a, b) {
      return int.parse(a).compareTo(int.parse(b));
    });
    li = List.from(li!.reversed);
    setState(() {
      li = li;
    });
   }
  }

  @override
  void initState() {
    initialize();
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

  Container getElement(int i) {
    

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child: Text(li![i],
            style: GoogleFonts.fredokaOne(color: Colors.green, fontSize: 40)));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordes'),
      ),
      backgroundColor: cobrinhaTheme.background,
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Padding(
                padding: EdgeInsets.only(top: 6, bottom: 24),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      Container(
                margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                child: Center(
                    child: Text("Modo Normal",
                        style: GoogleFonts.permanentMarker(
                            fontSize: 30,
                            color: cobrinhaTheme.color,
                            fontWeight: FontWeight.bold))),
              ),
              if (li != null) 
              for (int i = 0; i < 1; i++) getElement(i)
                    ],
                  )
                ),
                
              ),  
      ),
      
      
      /*
      Container(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                child: Center(
                    child: Text("Maiores Pontuação Normal",
                        style: GoogleFonts.permanentMarker(
                            fontSize: 30,
                            color: cobrinhaTheme.color,
                            fontWeight: FontWeight.bold))),
              ),
              if (li != null) 
              for (int i = 0; i < (li!.length); i++) getElement(i)
            ],
          )),*/

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