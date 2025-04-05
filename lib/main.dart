import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//st

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradient Background Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GradientBackgroundPage(),
    );
  }
}

class GradientBackgroundPage extends StatelessWidget {
  const GradientBackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using Container with BoxDecoration for the background instead of scaffoldBackgroundColor
      body: Container(
        // BoxDecoration allows us to add a gradient
        decoration: const BoxDecoration(
          // Linear gradient from top to bottom
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              //Gradient Colors
              Color.fromARGB(255, 0, 255, 200),
              Color.fromARGB(255, 23, 219, 108),
            ],
          ),
        ),
        // Child content of your app
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  // TODO: Replace text with LOGO
                  'LOGO',
                  style: TextStyle(
                    fontSize: 100,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  // TODO: Replace text with LOGO
                  'Get Started',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HoverAnimation extends StatefulWidget {
  const HoverAnimation({super.key});

  @override
  State<HoverAnimation> createState() => _HoverAnimationState();
}

class _HoverAnimationState extends State<HoverAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  ); // TODO: Make Final??
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
