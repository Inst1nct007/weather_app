import 'dart:ffi';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/front-end/pages/about.dart';
import 'package:weather_app/front-end/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        duration: 1000,
        splash: Transform.scale(child: Image.asset('assets/images/clouds.png',), scale: 2,),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color(0xffb8b8ff),
        nextScreen: HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var pages;
  late int currentIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pages = [const MyHomePage(), const About()];
    pageController = PageController();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb8b8ff),
      appBar: AppBar(
        title: Text(
          'Air Quality Predictor',
          style: GoogleFonts.abel(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffb8b8ff),
        elevation: 0,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: const Color(0xfff8f7ff),
        fixedColor: const Color(0xff9381ff),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'About',
          ),
        ],
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
