import 'dart:developer';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/apis.dart';
import '../dialogues/dialogues.dart';
import '../main.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isAnimate=false;
  bool agree=false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 500), (){
      setState(() {
        _isAnimate=true;
      });
    });
  }
  _handleGoogleBtnClick() {
    Dialogues.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user!=null) {
        if ((await APIs.userExists())){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>  HomePage()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_)=> HomePage()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {

      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch(e) {
      log('\n _signInWithGoogle: $e');
      Dialogues.showSnackBar(context, "Something went wrong!!!",Colors.red);
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      body:
      Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: mq.height*.15,
              left: mq.width*.1,
              child: AnimatedOpacity(
                opacity: _isAnimate?1:0,
                duration: Duration(milliseconds: 1500),
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 25),
                        children: [
                          TextSpan(
                              text:'Welcome to HackerNews...',
                              style: TextStyle(fontSize:30, fontFamily: "RaleWay",fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:'\n'+'\t'*10+'Swiggy your way',
                              style: TextStyle(fontWeight: FontWeight.w300,color: Colors.orange)),
                          TextSpan(
                              text:'\n'+'\t'*19+'to deliciousness...',
                              style: TextStyle(fontWeight: FontWeight.w300,color: Colors.orange))])),
              )),
          AnimatedPositioned(
              top: _isAnimate?mq.height*.35:mq.height*.30,
              right: mq.width*.25,
              width: mq.width*.5,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedOpacity(
                  opacity: _isAnimate?1:0,
                  duration: Duration(milliseconds: 1500),
                  child: Image.asset('assets/images/icon.png'))),
          Positioned(
              top: mq.height*.71,
              height: mq.height*.05,
              child: AnimatedOpacity(
                opacity: _isAnimate?1:0,
                duration: Duration(milliseconds: 1500),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          focusColor: Colors.lightBlue,
                          activeColor: Colors.orange,
                          value: agree,
                          onChanged: (newValue) {
                            setState(() {
                              agree=!agree;
                            });
                          }
                      ),
                      Text('I Accept the ',style: TextStyle(
                          fontSize: 15,fontWeight: FontWeight.w400
                      ),),
                      InkWell(
                        onTap: () => launchUrl(Uri.parse('https://doc-hosting.flycricket.io/twinkleoii-privacy-policy/ab73f448-53b5-4c4a-9bea-46692ecab34b/privacy')),
                        child: Text('Privacy Policy',style: TextStyle(
                          fontSize: 15,fontWeight: FontWeight.w400,decoration: TextDecoration.underline,
                        ),),
                      ),
                      Text(' & ',style: TextStyle(
                          fontSize: 15,fontWeight: FontWeight.w400
                      ),),
                      InkWell(
                        onTap: () => launchUrl(Uri.parse('https://doc-hosting.flycricket.io/twinkleoii-terms/a179d15e-7d93-49eb-884f-7e3c504ec347/terms')),
                        child: Text('Terms',style: TextStyle(
                          fontSize: 15,fontWeight: FontWeight.w400,decoration: TextDecoration.underline,
                        ),),
                      ),
                      SizedBox(width: 20.0),

                    ]),
              )),
          Positioned(
              top: mq.height*.80,
              width: mq.width*.9,
              height: mq.height*.05,
              child: AnimatedOpacity(
                opacity: _isAnimate?1:0,
                duration: Duration(milliseconds: 1500),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent.shade200),
                    onPressed: (){
                      if (agree==true) {
                        _handleGoogleBtnClick();
                      } else {
                        Dialogues.showSnackBar(context, "Accept policy & terms to continue!!!",Colors.orangeAccent.shade400);
                      }
                    }, icon: Image.asset('assets/images/google.png',height: 25,),
                    label: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 19),
                          children: [
                            TextSpan(text: 'Log in with '),
                            TextSpan(
                                text:'Google',
                                style: TextStyle(fontWeight: FontWeight.w500)),

                          ]),
                    )),
              )),
          Positioned(
              top: mq.height*.89,
              child:  AnimatedOpacity(
                opacity: _isAnimate?1:0,
                duration: Duration(milliseconds: 1500),
                child: InkWell(
                  onTap: () => launchUrl(Uri.parse('https://github.com/Pranav-P-16')),
                  child: Text(
                    'Made with love 🧡',
                    style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                ),
              )
          )],),
    );
  }
}
