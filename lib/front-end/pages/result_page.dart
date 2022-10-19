import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Result extends StatefulWidget {
  final double prediction;

  const Result({Key? key, required this.prediction}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late RxDouble number;
  late ConfettiController confettiController;
  @override
  void initState() {
    super.initState();
    number = 0.0.obs;
    confettiController =
        ConfettiController(duration: const Duration(seconds: 15));
  }

  void numberChanger() async {
    int i = 0;
    for (int i = 0; i < widget.prediction.toInt(); i++) {
      number.value = i.toDouble();
      await Future.delayed(const Duration(milliseconds: 10));
    }
    number.value = widget.prediction;
    confettiController.play();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    numberChanger();
    return Scaffold(
      backgroundColor: const Color(0xffb8b8ff),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
            colors: const [
              Color(0xffb8ffdb),
              Color(0xffbde0fe),
              Color(0xffffb8db),
              Color(0xffffffb8),
            ],
              //createParticlePath: drawStar
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Predicted AQI is : ',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 38,
                ),
                Obx(
                  () => Text(
                    number.toStringAsFixed(3),
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Go Back',
                    style: TextStyle(color: Color(0xffb8b8ff)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      shadowColor: Color(0xff9381ff)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
