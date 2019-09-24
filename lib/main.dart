import 'dart:async';
import 'config.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:animated_splash/animated_splash.dart';

void main() => runApp(App());
const String testDevice = 'MobileId';
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: CustomConfig.title,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home:  AnimatedSplash(
              imagePath: 'assets/'+CustomConfig.splashImage,
              home: MyHomePage(),
              duration: 2500,
              type: AnimatedSplashType.StaticDuration,
            ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).padding.top
          ),
          child: new Padding(
            padding: const EdgeInsets.only(
                left: 30.0,
                top: 5.0,
                bottom: 5.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  CustomConfig.title,
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),
                ),
                IconButton(icon: Icon(Icons.refresh),color: Colors.white,onPressed: (){
                  createInterstitialAd()
                    ..load()
                    ..show();
                },)
              ],
            ),
          ),
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Color(0xFF00B4DB),
                    Color(0xFF0083B0),
                  ]
              ),
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey[500],
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                )
              ]
          ),
        ),
        preferredSize: new Size(
            MediaQuery.of(context).size.width,
            150.0
        ),
      ),
      body: Container(child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: CustomConfig.getUrl,
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
      ),


      ),

//      floatingActionButton: FutureBuilder<WebViewController>(
//        future: _controller.future,
//        builder: (BuildContext context,AsyncSnapshot<WebViewController> controller){
//          if(controller.hasData){
//            return FloatingActionButton(
//
//              child: Icon(Icons.ac_unit),
//              onPressed: (){
//                controller.data.loadUrl("https://www.coolflutter.com/");
//              },
//            );
//          }
//        },
//      ),

    );
  }
}
