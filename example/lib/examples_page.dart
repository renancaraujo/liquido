import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquido/liquido.dart';

class ExamplesPage extends StatefulWidget {
  const ExamplesPage({super.key});

  @override
  State<ExamplesPage> createState() => _ExamplesPageState();
}

class _ExamplesPageState extends State<ExamplesPage> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF04050A),
      body: SafeArea(
        child: Stack(
          children: [
            // PageView - full screen
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.passthrough,
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: const [
                      _ExampleCard(
                        title: 'Refractive Container',
                        color: Colors.pinkAccent,
                      ),
                      _ExampleCard(
                        title: 'Clock',
                        color: Colors.purpleAccent,
                      ),
                      _ExampleCard(
                        title: 'Player',
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  // Centered Glass widget
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Glass(
                        blurSigma: 0,
                        refractionBorder: 35,
                        saturationBoost: 1.1,
                        centerScale: 0.98,
                        edgeScale: 1.3,
                        shape: const RoundedSuperellipseBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 1 / 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom menu overlaying the PageView
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Back button
                    _CircleButton(
                      onTap: () => Navigator.of(context).pop(),
                      icon: Icons.arrow_back,
                    ),

                    const SizedBox(width: 5),
                    
                    // Tab indicator
                    _buildTabIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build tab indicator with page numbers
  Widget _buildTabIndicator() {
    // Calculate proper dimensions based on the tab item size
    final tabWidth = 55.0;
    final tabMargin = 0; // horizontal margin on both sides
    final tabTotalWidth = tabWidth + tabMargin;

    return Container(
      height: 65, // Match the height of the back button
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 0,
      ), // Reduced vertical padding
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Floating highlight that moves behind the active tab
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            top: 20.5, // Adjusted for much smaller highlight
            left:
                (_currentPage * tabTotalWidth) +
                tabMargin / 2 + 22.5, // Adjusted for smaller width
            child: Container(
              width: 25, // Reduced width by another 20px (total 45px smaller than original)
              height: 25, // Reduced height by another 20px (total 45px smaller than original)
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.5,
                ), // Semi-transparent black
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0, // Reduced padding to fit in 48px container
              ),
              child: Glass(
                blurSigma: 15,
               refractionBorder: 15,
                saturationBoost: 1.1,
                     centerScale: 0.98,
                edgeScale: 1.2,
                grainIntensity: 0.05,
                brightnessCompensation: -0.25,
                glassTint: Colors.black.withOpacity(0.15), // Darker tint to match black indicator

                shape: const RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          // Row of tab numbers
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < 3; i++) _buildTabItem(i),
            ],
          ),
        ],
      ),
    );
  }

  // Build individual tab item
  Widget _buildTabItem(int index) {
    final isActive = _currentPage == index;

    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 40,
        height: 50, // Match the height of the floating highlight
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Text(
            '${index + 1}',
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.normal,
              color: Colors.white,
              shadows: [
                if (isActive)
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final Color color;

  const _ExampleCard({
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: SizedBox(
        height: 300,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: color.withOpacity(0.7),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const _CircleButton({
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        height: 55,
        child: Stack(
          children: [
            
            // Glass overlay
            Positioned.fill(
              child: Glass(
                blurSigma: 45,
                refractionBorder: 10,
                saturationBoost: 1.1,
                centerScale: 1.0,
                edgeScale: 1.2,
                grainIntensity: 0.05,
                brightnessCompensation: -0.3,
                glassTint: Colors.white.withOpacity(0.1), // More neutral ti
                shape: const CircleBorder(),
              ),
            ),
            // Icon
            Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
