import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh/mesh.dart';
import 'package:liquido/liquido.dart';
import 'examples_page.dart';

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
          // Text layer
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final fontSize = constraints.maxWidth < 600
                    ? constraints.maxWidth * 0.2
                    : 280.0;
                return Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Padding(
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
                    ),
                    const Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 56,
                          vertical: 8,
                        ),
                        child: Glass(
                          key: Key('liquido-glass'),
                          blurSigma: 20,
                          refractionBorder: 2,
                          saturationBoost: 1.1,
                          // contrastBoost: 1.2,
                          centerScale: 0.8,
                          brightnessCompensation: -0.1,
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(66),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Examples button at the bottom
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Glass(
                blurSigma: 0,
                refractionBorder: 2,
                brightnessCompensation: 0.01,
                centerScale: 0.2,

                boxShadow: BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder<void>(
                          pageBuilder: (context, animation, secondaryAnimation) => const ExamplesPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.easeOutQuint;
                            
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            
                            return SlideTransition(
                              position: offsetAnimation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 32,
                      ),
                      child: Text(
                        'Examples',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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

// https://omesh-playground.renan.gg/#/h/OM:eAFjDN2_bkfg61a5Hftbqh66rxOpZrA_BxXYCCID3zDYPwDzg_bv0fh6qD9Gk8H--ToRkOL9K2eCwCwG-w8QvfunQM3YvwTCsL8K1KDx9TCD_QUGMLC_BOIf6mewv6vyVuXRdhH7S5JGAZtlzzHYv4CqgKqEG2p_0R1knQfD_kVuBjXH2fbZ35mo5qLpfp_B_jJD8KJbc__aP5jh18U0z4HB_unmy3vjqh7Z32rulqwpOcpl_4JpQU_JzVD7m538WZdPKNjff9RxKJvL3v5OvoCFybEN9u9CBXdnttbY3y_vKL419xiX_Ycis0_6S9hgAvavdKR_3NIMtr_bwxyq5H0L7qibUK_vXzqBr732ubr9w9_snbkvQY5S_np681IW-8eceauLJc5z2d_sijGS4k6zf3jwwLQf5m32Z7iqPk-wv2D_-L-h1XnHo_ZPZ96yS5xx3P4Bz7OVSSceMNi_fXor43rafPvHkj1vrxoJM8IFHtyR8fynfhXuiGdpYMCwfx4kyuw_LL7OZVuwhMH-GkTG_gMk6hjsn5wBgbP2H0BRqPENaAkkZhAqPsqBDJGHGc7AxbD28a__DO9-_P_PcPU1kHj7FUi8f_G_mOEFSIzBbg-Q8DoBJEKm_mdgYlL5zggCTMwsLCysbEDAzsHBzskFAjYMpx6_-Q8mAF_jKio
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
    (1.03, -0.02).v, // Row 1
    (-0.04, 0.34).v,
    (0.25, 0.29).v,
    (0.46, 0.28).v,
    (0.75, 0.25).v,
    (1.03, 0.27).v, // Row 2
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
    (1.03, 0.4).v, // Row 3
    (-0.04, 0.56).v,
    (0.3, 0.59).v.bezier(
      east: (0.4, 0.55).v,
      west: (0.22, 0.62).v,
    ),
    (0.68, 0.5).v,
    (0.93, 0.6).v.bezier(
      north: (0.93, 0.53).v,
    ),
    (1.03, 0.7).v, // Row 4
    (-0.03, 1.04).v,
    (0.35, 1.02).v,
    (0.65, 1.06).v,
    (0.93, 1.02).v,
    (1.07, 1.03).v, // Row 5
  ],
  colors: const [
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa), // Row 1
    Color(0xffeef8ff),
    Color(0xffd5ebff),
    Color(0xffedf5ff),
    Color(0xffedf5ff),
    Color(0xffedf5ff), // Row 2
    Color(0x73efe8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff), // Row 3
    Color(0xff003ebc),
    Color(0xff004ac8),
    Color(0xff004ac8),
    Color(0xff003ebc),
    Color(0xff005495), // Row 4
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224), // Row 5
  ],
);

// https://omesh-playground.renan.gg/#/h/OM:eAFjDN2_bkfg61a5Hftbqh66rxOpZrA_BxXYCCID3zDYPwDzg_bv0fh6qD9Gk8H--ToRkOL9K2eCwCwG-w8QvfunQM3YvwTCsL8K1KDx9TCD_QUGMLC_BOIf6mewv6vyVuXRdhH7S5JGAZtlzzHYv4CqgKqEG2p_0R1knQfD_kVuBjXH2fbZ35mo5qLpfp_B_srnKPk5tgb2d5o-v5j1cRWD_dPk3yszSh_ZP_yZuWu56x0u-9cn9tb-Ed1s_2jzBEMdZgb7hw5ztnLPErd_0JC8LtD9qf27UMHdma019vfLO4pvzT3GZf-hyOyT_hI2mID9Kx3pH7c0g-3v9jCHKnnfgjvqJtTr-5dO4Guvfa5u__A3e2fuy_tM9gu5_Tf0J163f_DGbluMZZz9Zf7_x7YpH7W___LjmdX-Alz2d0qevdmzix-oQDtx0isd-zNMdR8n2gfY313ee_9lnLz9Uwlp2Y8XVtk_jrWrrdj7ksv-RY0au2N3mP2Tink37q2Mt3-0yfBro7SZ_aMDTZdn3XGxf_v0Vsb1tPn2jyV73l41EmaECzy4I-P5T_0q3NHP0sCAYf88SBTbf1h8ncu2YAmD_TWIjP0HSFQz2D85AwJn7T-AolzjG4P9W0hMIlR8lAMZIg8znIGbYe3jX_8Z3v34_5_h6msg8fYrkHj_4n8xwwuQGIPdnv8M_gxfgSyvE0AiZOp_BiYmle-MIMDEzMLCwsoGBOwcnOxc3CBgw3Dq8Zv_YAIAz0FIYQ
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
    (1.03, -0.02).v, // Row 1
    (-0.04, 0.34).v,
    (0.25, 0.29).v,
    (0.46, 0.28).v,
    (0.75, 0.25).v,
    (1.03, 0.27).v, // Row 2
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
    (1.03, 0.4).v, // Row 3
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
    (1.03, 0.7).v, // Row 4
    (-0.03, 1.04).v,
    (0.35, 1.02).v,
    (0.65, 1.06).v,
    (0.93, 1.02).v,
    (1.07, 1.03).v, // Row 5
  ],
  colors: const [
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa),
    Color(0xffade3fa), // Row 1
    Color(0xffeef8ff),
    Color(0xffd5ebff),
    Color(0xffedf5ff),
    Color(0xffedf5ff),
    Color(0xffedf5ff), // Row 2
    Color(0x73efe8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff),
    Color(0xffe8f8ff), // Row 3
    Color(0xff003ebc),
    Color(0xff4f00f5),
    Color(0xff004ac8),
    Color(0xff003ebc),
    Color(0xff005495), // Row 4
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224),
    Color(0xf7020224), // Row 5
  ],
);
