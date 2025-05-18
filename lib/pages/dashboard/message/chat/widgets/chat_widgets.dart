
import 'package:flutter/material.dart';

/// A function that builds a your message widget.
Widget yourMsg(String msg) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(msg),
          ),
        ),
        
      ],
    ),
  );
}

/// A function that builds the response message widget.
Widget responseMsg(String msg) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          
            child: Text(msg),
          ),
        ),
      ],
    ),
  );
}
