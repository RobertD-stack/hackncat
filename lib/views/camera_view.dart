import 'dart:io';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackncat/controller/scan_controller.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:process_run/shell.dart'; // Optional, if you're using process_run

// Function to run Python script and capture its output
Future<String?> runPythonScript(String base64Image) async {
  final shell = Shell();

  try {
    final result = await shell.run(
      'python3 model.py "$base64Image"', // Pass the base64 string as argument
    );
    return result.join('\n'); // Capture and return the output
  } catch (e) {
    return 'Error running Python script: $e';
  }
}

// Function to pick and encode the image
Future<String?> pickAndEncodeImage() async {
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    final imageFile = File(pickedFile.path);

    // Read the image file and convert to base64
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    return base64Image; // Return the base64 string
  } else {
    return null; // No image was selected
  }
}

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScanController());

    return Scaffold(
      body: Obx(() {
        return controller.isCameraInitialized.value
            ? Stack(
              children: [
                // Camera preview
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width:
                              controller
                                  .cameraController
                                  .value
                                  .previewSize!
                                  .height,
                          height:
                              controller
                                  .cameraController
                                  .value
                                  .previewSize!
                                  .width,
                          child: CameraPreview(controller.cameraController),
                        ),
                      ),
                    ),
                  ),
                ),

                // Capture button
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: () async {
                        try {
                          // Take the picture
                          final XFile photo =
                              await controller.cameraController.takePicture();
                          // Create a custom directory path for permanent storage
                        } catch (e) {
                          // Handle errors
                          print("Error capturing image: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.camera_alt, color: Colors.black),
                    ),
                  ),
                ),
                ImageUploader(),
              ],
            )
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  File? _imageFile;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
          _imageFile = File(pickedFile.path);
        });

        // You can do something with the image path here
        print('Selected image path: $_imagePath');
        if (_imagePath != null) {
          final result = await Process.run(
            'py', // or 'python' depending on your system
            [
              'model.py',
              _imagePath!,
            ], // Passing the image path as an argument to the script
          );
        } else {
          print("Image path is null.");
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display file name if available
        if (_imagePath != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Selected: ${path.basename(_imagePath!)}',
              style: const TextStyle(fontSize: 14),
            ),
          ),

        // Upload button
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload Image'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
