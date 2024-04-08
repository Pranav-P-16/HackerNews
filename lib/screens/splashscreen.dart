import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackernews/api/apis.dart';
import 'package:hackernews/screens/loginpage.dart';
import 'package:hackernews/topArticleList.dart';
import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimate=false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 500), (){
      setState(() {
        _isAnimate=true;
      });
    });
//    Firebase.initializeApp();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(systemNavigationBarColor:Colors.transparent,statusBarColor: Colors.transparent)
    );
    if (APIs.auth.currentUser!=null) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        // log('\nUser: ${APIs.auth.currentUser}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>  TopArticleList()));
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2000), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const LoginPage()));
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    mq=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Stack(children: [
        AnimatedPositioned(
            top: mq.height*.32,
            right:mq.width*.25,
            width: mq.width*.5,
            duration: const Duration(milliseconds: 600),
            child: AnimatedOpacity(
                duration: Duration(milliseconds: 600),
                opacity: _isAnimate?1:0,
                child: Image.asset('assets/images/icon.png'))),
        Positioned(
            top: mq.height*.75,
            left: mq.width*.15,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 700),
              opacity: _isAnimate?1:0,
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 30),
                      children: [
                        TextSpan(
                            text:'Hacker',
                            style: TextStyle(fontWeight: FontWeight.w400)),
                        TextSpan(
                            text:'News...',
                            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.orange)),
                        TextSpan(
                            text: '☢☢',
                            style: TextStyle(fontWeight: FontWeight.w300))])),
            )),
        Positioned(
          top: mq.height*.85,
          right: mq.width*.12,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 600),
            opacity: _isAnimate?1:0,
            child: Text("Version 1.0.0",style: TextStyle(
                fontSize: 20,fontWeight: FontWeight.w300
            ),),
          ),
        ),

      ],),
    );
  }
}
