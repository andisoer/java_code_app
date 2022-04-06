import 'package:flutter/material.dart';

BoxDecoration appBarDecoration(BuildContext context) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withAlpha(70),
        blurRadius: 2,
        spreadRadius: 5,
      ),
    ],
  );
}
