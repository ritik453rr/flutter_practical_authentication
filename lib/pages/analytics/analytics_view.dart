import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Center(
        child: 
         ElevatedButton(
            onPressed: () async {
               await FirebaseAnalytics.instance.logEvent(
                name: "testz",
                parameters: {
                  "content_type": "image",
                  "item_id": "1234",
                  "content_name": "Profile Picture",
                  "content_category": "Profile",
                  "user_id": "user_123",
                  "user_name": "John Doe",
                },
              ).then((value) {
                print("Event logged successfully:");
              }).catchError((error) {
                print("Error logging event: $error");
              }).catchError((error) {
                print("Error logging event: $error");
              });
            },
            child: const Text('Fire Event'),
          ),
      ),
    );
  }
}