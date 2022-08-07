import 'package:cobrinha/pages/home_page.dart';
import 'package:cobrinha/splash_screen/splash_screen.dart';
import 'package:cobrinha/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

   runApp( const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Cobra',
      debugShowCheckedModeBanner: false,
      theme: cobrinhaTheme.theme,
      home: const SplashScreen(),
    );
  }
}

