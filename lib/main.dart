import 'package:flutter/material.dart';

void main() {
  runApp(const FirstRoute());
}
//st

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradient Background Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // ensures full screen tap detection
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondRoute()),
          );
        },
        child: Container(
          // BoxDecoration allows us to add a gradient
          decoration: const BoxDecoration(
            // Linear gradient from top to bottom
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                //Gradient Colors
                Color.fromARGB(255, 0, 103, 197),
                Color.fromARGB(255, 99, 170, 237),
              ],
            ),
          ),
          // Child content of your app
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HoverAnimation(),
                  const SizedBox(height: 30),
                  const Text(
                    // TODO: Replace text with LOGO
                    'TAP TO LOGIN',
                    style: TextStyle(
                      fontFamily: "Silkscreen",
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
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
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize only once with proper settings
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(
      reverse: true,
    ); // Adding reverse makes it float up and down smoothly

    // Initialize animation after controller is properly set up
    _animation = Tween(begin: Offset.zero, end: Offset(0, 0.08)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // This will make the animation smoother
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.asset("assets/ecosnap8bitwhite.png", width: 300),
    );
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    // Bounce in
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Replace Placeholder with actual content
    return Scaffold(
      // Using Container with BoxDecoration for the background instead of scaffoldBackgroundColor
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // ensures full screen tap detection
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondRoute()),
          );
        },
        child: Container(
          // BoxDecoration allows us to add a gradient
          decoration: const BoxDecoration(
            // Linear gradient from top to bottom
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                //Gradient Colors
                Color.fromARGB(255, 0, 103, 197),
                Color.fromARGB(255, 99, 170, 237),
              ],
            ),
          ),
          // Child content of your app
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HoverAnimation(),
                  const SizedBox(height: 30),
                  ObscuredTextField(label: "Username"),
                  ObscuredTextField(label: "Password"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ObscuredTextField extends StatelessWidget {
  final String label;
  const ObscuredTextField({super.key, required this.label});
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
