import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackncat/controller/scan_controller.dart';
import 'package:get/get.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScanController());

    return Scaffold(
      body: Obx(() {
        return controller.isCameraInitialized.value
            ? CameraPreview(controller.cameraController)
            : const Center(child: Text("Loading Preview..."));
      }),
    );
  }
}
