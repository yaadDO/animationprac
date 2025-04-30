import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double boxHeight = 100;
  double boxWidth = 100;
  Color boxColor = Colors.cyan;
  BorderRadius _borderRadius = BorderRadius.circular(8);
  final random = Random();
  double _rotation = 0;
  bool isGradient = false;
  double animationSpeed = 1;

  void _changeBoxSize() {
    setState(() {
      boxWidth = random.nextInt(400).toDouble();
      boxHeight = random.nextInt(400).toDouble();
    });
  }

  void _changeBoxColor() {
    setState(() {
      boxColor = Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
    });
  }

  void _changeRadius() {
    setState(() {
      _borderRadius = BorderRadius.circular(random.nextInt(80).toDouble());
    });
  }

  void _rotateBox() {
    setState(() => _rotation = random.nextDouble() * 2 * pi);
  }

  void _toggleGradient() {
    setState(() => isGradient =! isGradient);
  }

  void _resetAll() {
    setState(() {
      boxHeight = 100;
      boxWidth = 100;
      boxColor = Colors.cyan;
      _borderRadius = BorderRadius.circular(8);
      _rotation = 0;
      isGradient = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: (1000 * animationSpeed).round()),
                  curve: Curves.bounceOut,
                  width: boxWidth,
                  height: boxHeight,
                  transform: Matrix4.rotationZ(_rotation),
                  transformAlignment: Alignment.center,
                  constraints: const BoxConstraints(
                    minWidth: 50,
                    minHeight: 50,
                  ),
                  decoration: BoxDecoration(
                    color: isGradient ? null : boxColor,
                    gradient: isGradient ? LinearGradient(colors: [boxColor, Colors.white]) : null,
                    borderRadius: _borderRadius,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(4, 4)
                      ),
                    ]
                  ),
                  child: const Center(
                    child: Text(
                      'Kspr',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              value: animationSpeed,
              min: 0.1,
              max: 5.0,
              onChanged: (value) => setState(() => animationSpeed = value),
              divisions: 19,
              label: '${animationSpeed.toStringAsFixed(1)}s',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: _changeBoxColor, icon: const Icon(Icons.color_lens)),
                IconButton(onPressed: _changeBoxSize, icon: const Icon(Icons.grid_goldenratio)),
                IconButton(onPressed: _changeRadius, icon: const Icon(Icons.radar)),
                IconButton(onPressed: _rotateBox, icon: const Icon(Icons.sports_cricket)),
                IconButton(onPressed: _toggleGradient, icon: const Icon(Icons.gradient)),
                IconButton(onPressed: _resetAll, icon: const Icon(Icons.videogame_asset_rounded)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

