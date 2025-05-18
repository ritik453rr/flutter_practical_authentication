import 'package:authentication_ptcl/pages/crashlytics/crashlytics_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrashlyticsView extends StatelessWidget {
 CrashlyticsView({super.key});

  final controller = Get.find<CrashlyticsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crashlytics'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              child: const Text("Force Crash"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseCrashlytics.instance.recordError("Error", null,
                      reason: 'a fatal error',
                      // Pass in 'fatal' argument
                      fatal: true);
                },
                child: Text("Fatal Error")),
          ],
        ),
      ),
    );
  }
}
