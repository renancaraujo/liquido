import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh/mesh.dart';
import 'package:liquido/liquido.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquido Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF04050A),
      ),
      home: const LiquidoHomePage(),
    );
  }
}

class LiquidoHomePage extends StatefulWidget {
  const LiquidoHomePage({super.key});

  @override
  State<LiquidoHomePage> createState() => _LiquidoHomePageState();
}

class _LiquidoHomePageState extends State<LiquidoHomePage> {
  OMeshRect _currentMesh = meshRect1;
  late Timer _timer;
  double _rotationAngle = -0.2;
  bool _showClock = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentMesh = _currentMesh == meshRect1 ? meshRect2 : meshRect1;
        _rotationAngle = _rotationAngle == -0.2 ? 0.2 : -0.2;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: 1600,
                height: 1200,
                child: AnimatedOMeshGradient(
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubic,
                  mesh: _currentMesh,
                ),
              ),
            ),
          ),
          // Only show the "liquido" text when not showing the clock
          if (!_showClock)
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final fontSize = constraints.maxWidth < 600
                      ? constraints.maxWidth * 0.2
                      : 280.0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOutCubic,
                      transform: Matrix4.rotationZ(_rotationAngle),
                      transformAlignment: Alignment.center,
                      child: Text(
                        'liquido',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        softWrap: false,
                        style: GoogleFonts.nunito(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          // Display either clock or superellipse based on _showClock state
          if (_showClock) GlassTextPage(rotationAngle: _rotationAngle) else SuperellipseGlassPage(rotationAngle: _rotationAngle),
          // Toggle button positioned closer to the middle
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3, // Position at 60% from the top
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showClock = !_showClock;
                  });
                },
                child: Glass(
                  blurSigma: 20,
                  refractionBorder: 6.5,
                  
                  
                  brightnessCompensation: 0.1,
                  shape: StadiumBorder(),
                  boxShadow: BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      _showClock ? 'Show Superellipse' : 'Show Clock',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuperellipseGlassPage extends StatelessWidget {
  final double rotationAngle;

  const SuperellipseGlassPage({
    super.key,
    required this.rotationAngle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return const Glass(
            key: Key('liquido-glass-superellipse'),
            blurSigma: 20,
            refractionBorder: 2,
            saturationBoost: 1.1,
            centerScale: 0.8,
            brightnessCompensation: -0.1,
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(66),
              ),
            ),
            child: SizedBox(
              width: 200,
              height: 100,
            ),
          );
        },
      ),
    );
  }
}

class GlassTextPage extends StatefulWidget {
  final double rotationAngle;

  const GlassTextPage({
    super.key,
    required this.rotationAngle,
  });

  @override
  State<GlassTextPage> createState() => _GlassTextPageState();
}

class _GlassTextPageState extends State<GlassTextPage> {
  late String _timeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    // Update time every minute
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    setState(() {
      _timeString = '$hour:$minute';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fontSize = constraints.maxWidth < 600
              ? constraints.maxWidth * 0.3
              : 280.0;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Glass.text(
              _timeString,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: GoogleFonts.nunito(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
              ),
              blurSigma: 35,
              // saturationBoost: 0.7,
              // brightnessCompensation: 0.2,
              refractionBorder: 9,
              boxShadow: BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
            ),
          );
        },
      ),
    );
  }
}

final meshRect1 = OMeshRect(
  width: 5,
  height: 5,
  fallbackColor: const Color(0xffcae3ec),
  backgroundColor: const Color(0xffcae3ec),
  vertices: [
    (-0.06, -0.01).v,
    (0.24, -0.07).v,
    (0.51, -0.11).v,
    (0.74, -0.05).v,
    (1.03, -0.02).v,
    (-0.04, 0.34).v,
    (0.25, 0.29).v,
    (0.46, 0.28).v,
    (0.75, 0.25).v,
    (1.03, 0.27).v,
    (-0.04, 0.45).v,
    (0.3, 0.52).v,
    (0.68, 0.41).v.bezier(
      east: (0.75, 0.4).v,
      west: (0.5, 0.44).v,
    ),
    (0.95, 0.49).v.bezier(
      east: (1.03, 0.49).v,
      west: (0.82, 0.46).v,
    ),
    (1.03, 0.4).v,
    (-0.04, 0.56).v,
    (0.3, 0.59).v.bezier(
      east: (0.4, 0.55).v,
      west: (0.22, 0.62).v,
    ),
    (0.68, 0.5).v,
    (0.93, 0.6).v.bezier(
      north: (0.93, 0.53).v,
    ),
    (1.03, 0.7).v,
    (-0.03, 1.04).v,
    (0.35, 1.02).v,
    (0.65, 1.06).v,
    (0.93, 1.02).v,
    (1.07, 1.03).v,
  ],
  colors: const [
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffeef8ff),
    Color(0xffd5ebff),
    Color(0xffedf5ff),
    Color(0xffedf5ff),
    Color(0xffedf5ff),
    Color(0x73efe8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xff003ebc),
    Color(0xff004ac8),
    Color(0xff004ac8),
    Color(0xff003ebc),
    Color(0xff005495),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
  ],
);

final meshRect2 = OMeshRect(
  width: 5,
  height: 5,
  fallbackColor: const Color(0xffcae3ec),
  backgroundColor: const Color(0xffcae3ec),
  vertices: [
    (-0.06, -0.01).v,
    (0.24, -0.07).v,
    (0.51, -0.11).v,
    (0.74, -0.05).v,
    (1.03, -0.02).v,
    (-0.04, 0.34).v,
    (0.25, 0.29).v,
    (0.46, 0.28).v,
    (0.75, 0.25).v,
    (1.03, 0.27).v,
    (-0.04, 0.45).v,
    (0.33, 0.45).v,
    (0.67, 0.56).v.bezier(
      east: (0.87, 0.58).v,
      west: (0.54, 0.52).v,
    ),
    (0.95, 0.49).v.bezier(
      east: (1.03, 0.49).v,
      west: (0.82, 0.46).v,
    ),
    (1.03, 0.4).v,
    (-0.04, 0.56).v.bezier(
      east: (0.03, 0.53).v,
    ),
    (0.3, 0.5).v.bezier(
      east: (0.44, 0.53).v,
      west: (0.22, 0.46).v,
    ),
    (0.66, 0.61).v.bezier(
      east: (0.77, 0.64).v,
      west: (0.58, 0.59).v,
    ),
    (0.93, 0.6).v.bezier(
      north: (0.93, 0.53).v,
    ),
    (1.03, 0.7).v,
    (-0.03, 1.04).v,
    (0.35, 1.02).v,
    (0.65, 1.06).v,
    (0.93, 1.02).v,
    (1.07, 1.03).v,
  ],
  colors: const [
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffeef8ff),
    Color(0xffd5ebff),
    Color(0xffedf5ff),
    Color(0xffedf5ff),
    Color(0xffedf5ff),
    Color(0x73efe8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xff003ebc),
    Color(0xff4f00f5),
    Color(0xff004ac8),
    Color(0xff003ebc),
    Color(0xff005495),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
  ],
);
