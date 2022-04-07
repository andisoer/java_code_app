import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/style/colors.dart';

Container buildCategoryTitle(String title, String assetImage) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
    child: Row(
      children: [
        Image.asset(assetImage),
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        )
      ],
    ),
  );
}
