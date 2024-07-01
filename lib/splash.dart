import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fruitsynergy_tracker/home.dart';
import 'package:fruitsynergy_tracker/loadingScreen.dart';

class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{

  late AnimationController? _controller;
  late Animation<double>? _animation;

  @override
  void initState(){
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );

    _controller!.forward();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const HomePage())); // Replace HomePage with your main page
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation!,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset("assets/icon/wall.jpeg",fit: BoxFit.cover),
              ),
              ],
          ),
        ),
      ),
    );
  }
}

