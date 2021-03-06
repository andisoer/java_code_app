import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/common/navigation.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:java_code_app/page/detail_menu.dart';
import 'package:java_code_app/style/colors.dart';

InkWell buildItemMenu(BuildContext context, Menu menu) {
  return InkWell(
    onTap: () {
      Navigation.intentWithData(DetailMenuPage.routeName, menu.idMenu);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
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
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(menu.foto)),
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
                    menu.nama,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    menu.harga.toString(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: primaryColor,
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
                              color: const Color.fromARGB(255, 170, 170, 170),
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
                    side: BorderSide(
                      width: 2,
                      color: primaryColor,
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
                    color: Colors.white,
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
