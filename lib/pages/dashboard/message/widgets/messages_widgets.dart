

import 'package:flutter/material.dart';

/// A widget that represents a message item in the message list.
Widget messageItem({
  required String name,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
             
            ),

          ],
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        // Icon(Icons.arrow_forward_ios, color: AppColors.colorBlack, size: 16),
      ],
    ),
  );
}
