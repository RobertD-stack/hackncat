import 'package:flutter/material.dart';
import 'package:hackncat/views/camera_view.dart';


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
      body: Container(
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

              children: [HoverAnimation(), MyCustomForm()],
            ),
          ),
        ),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String _errorMessage = '';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey <FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ObscuredTextField(
              label: "Username",
              obscured: false,
              controller: _usernameController,
            ),
            const SizedBox(height: 30),
            ObscuredTextField(
              label: "Password",
              obscured: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 10),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  if (username == 'admin' && password == '1234') {
                    print("Success!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraView(),
                      ),
                    );
                  } else {
                    setState(() {
                      _errorMessage = 'Incorrect username and password';
                    });
                    print("Invalid credentials");
                  }
                }
              },

              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class ObscuredTextField extends StatelessWidget {
  final String label;
  final bool obscured;
  final TextEditingController controller;
  const ObscuredTextField({
    super.key,
    required this.label,
    required this.obscured,
    required this.controller,
  });
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a ' + label.toLowerCase();
          }
          return null;
        },
        obscureText: obscured,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}

class ThirdRoute extends StatefulWidget {
  const ThirdRoute({super.key});

  @override
  State<ThirdRoute> createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute>
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
      body: Container(
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
                const Text(
                  // TODO: Replace text with LOGO
                  'SUCCESS',
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
    );
  }
}

// A screen that allows users to take a picture using a given camera.
// class TakePictureScreen extends StatefulWidget {
//   const TakePictureScreen({super.key, required this.camera});

//   final CameraDescription camera;

//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();
// }

// class TakePictureScreenState extends State<TakePictureScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );

//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Fill this out in the next steps.
//     return Container();
//   }
// }
