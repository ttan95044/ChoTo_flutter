import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/screens/register.dart';
import 'package:flutter_database/component/button.dart';
import 'package:flutter_database/login.dart';
class Welcome extends StatefulWidget{
  const Welcome({Key? key}) :super(key: key);
  static const String id ='welcome_screen';
  @override
  State<Welcome> createState() => _WelComeState();
}

class _WelComeState extends State<Welcome> with SingleTickerProviderStateMixin{
  AnimationController? controller;
  Animation? animation;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = ColorTween(begin: Colors.blueAccent, end: Colors.white).animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            const CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage('lib/asset/img/1.png'),
            ),
            SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [TypewriterAnimatedText('')],
                  onTap:(){},
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              title: 'Đăng Nhập',
              colour: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, Login.id);
              },
            ),
            RoundedButton(
              title: 'Đăng Ký',
              colour: Colors.blueAccent,
              onPressed: (){
                Navigator.pushNamed(context, Register.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

