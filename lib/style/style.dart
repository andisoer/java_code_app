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

BoxDecoration cardDecoration() {
  return BoxDecoration(
    color: const Color.fromARGB(255, 246, 246, 246),
    boxShadow: [
      BoxShadow(
        blurRadius: 2,
        spreadRadius: 2,
        color: Colors.grey.withAlpha(70),
        offset: const Offset(0, 2),
      ),
    ],
    borderRadius: const BorderRadius.all(
      Radius.circular(12),
    ),
  );
}
