import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:shimmer/shimmer.dart';

Shimmer buildItemMenuShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.grey.withAlpha(70),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration:cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'lorem ipsum',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'rp 20000',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/add_note.png'),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Tambahkan catatan',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    side: const BorderSide(
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.remove),
                ),
                Text(
                  '1',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    backgroundColor: primaryColor,
                  ),
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
