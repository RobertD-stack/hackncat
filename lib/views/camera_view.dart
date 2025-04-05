import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackncat/controller/scan_controller.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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
              ],
            )
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
