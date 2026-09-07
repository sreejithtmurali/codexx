import 'package:codex/views/loginview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingData {
  final String titleNormal;
  final String titleHighlight;
  final String subtitle;
  final String buttonLabel;

  const _OnboardingData({
    required this.titleNormal,
    required this.titleHighlight,
    required this.subtitle,
    required this.buttonLabel,
  });
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      titleNormal: "Everything you need,\nfrom nearby ",
      titleHighlight: "stores.",
      subtitle:
      "Groceries, meat, medicine, bakery,\nelectricals & more  all in one app.",
      buttonLabel: "Get Started",
    ),
    _OnboardingData(
      titleNormal: "Your local stores,\none smart ",
      titleHighlight: "app.",
      subtitle:
      "Find what you need, order from nearby\nstores, and get it delivered to your doorstep.",
      buttonLabel: "Explore Stores",
    ),
  ];

  void _onSkip() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Login(),
      ),
    );
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Login(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final data = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/img.png',
                          height: 260,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 32),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.35,
                            ),
                            children: [
                              TextSpan(text: data.titleNormal),
                              TextSpan(
                                text: data.titleHighlight,
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          data.subtitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Skip / Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _onSkip,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 56),
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        "Skip",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      onPressed: _onNext,
                      icon: const Icon(Icons.arrow_forward, size: 18),
                      label: Text(
                        _pages[_currentPage].buttonLabel,
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 56),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}