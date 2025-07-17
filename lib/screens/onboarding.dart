import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _shakeController;

  final List<OnboardingItem> _pages = const [
    OnboardingItem(
      image: 'assets/onboarding_ai.svg',
      title: 'Meet Vaura',
      description: 'Your AI assistant for instant answers and smart automation',
      icon: Remix.robot_2_line,
      color: Color(0xFF6C5CE7),
    ),
    OnboardingItem(
      image: 'assets/onboarding_chat.svg',
      title: 'Natural Chat',
      description: 'Conversational AI that understands context and nuance',
      icon: Remix.chat_1_line,
      color: Color(0xFF00B8D9),
    ),
    OnboardingItem(
      image: 'assets/onboarding_security.svg',
      title: 'Privacy Focused',
      description: 'End-to-end encrypted conversations by default',
      icon: Remix.shield_keyhole_line,
      color: Color(0xFF36B37E),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  void _onSkip() => Navigator.pushReplacementNamed(context, '/home');
=======
  void _onSkip() => Navigator.pushReplacementNamed(context, '/auth');
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config

  void _onNext() {
    if (_currentPage == _pages.length - 1) {
      _onSkip();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    final isDark = Theme.of(context).brightness == Brightness.dark;
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
<<<<<<< HEAD
                  _pages[_currentPage].color.withAlpha(25),
=======
                  _pages[_currentPage].color.withAlpha(isDark ? 50 : 25),
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
                  Colors.transparent,
                ],
              ),
            ),
          ),
<<<<<<< HEAD
          _buildFloatingElements(),
=======
          _buildFloatingElements(isDark),
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) =>
                OnboardingPage(item: _pages[index]),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            right: 24,
            child: TextButton(
              onPressed: _onSkip,
<<<<<<< HEAD
              child: const Text('Skip'),
=======
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? _pages[_currentPage].color
<<<<<<< HEAD
                        : Colors.grey.withAlpha(128),
=======
                        : Theme.of(context).colorScheme.onSurface.withAlpha(77),
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 24,
            child: AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _shakeController.value * 2),
                  child: FloatingActionButton(
                    onPressed: _onNext,
                    backgroundColor: _pages[_currentPage].color,
                    child: Icon(
                      _currentPage == _pages.length - 1
                          ? Remix.check_line
                          : Remix.arrow_right_line,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildFloatingElements() {
=======
  Widget _buildFloatingElements(bool isDark) {
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
<<<<<<< HEAD
              color: _pages[_currentPage].color.withAlpha(12),
=======
              color: _pages[_currentPage].color.withAlpha(isDark ? 20 : 12),
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          right: -30,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
<<<<<<< HEAD
              color: _pages[_currentPage].color.withAlpha(7),
=======
              color: _pages[_currentPage].color.withAlpha(isDark ? 10 : 7),
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    final colorScheme = Theme.of(context).colorScheme;
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: item.color.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              size: 48,
              color: item.color,
            ),
          ),
<<<<<<< HEAD
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [item.color, item.color.withAlpha(178)],
            ).createShader(bounds),
            child: Text(
              item.title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
=======
          Text(
            item.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
          ),
          const SizedBox(height: 20),
          Text(
            item.description,
            textAlign: TextAlign.center,
<<<<<<< HEAD
            style: TextStyle(
              fontSize: 16,
              color:
                  Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(178),
            ),
=======
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withAlpha(178),
                ),
>>>>>>> ≡ƒöÉ Added .gitignore, release signing setup, deep link config
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SvgPicture.asset(
              item.image,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
