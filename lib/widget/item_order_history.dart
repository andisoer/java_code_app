import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/common/navigation.dart';
import 'package:java_code_app/common/utils.dart';
import 'package:java_code_app/data/model/order_history_result.dart';
import 'package:java_code_app/page/detail_order.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';

InkWell buildItemOrderHistory(BuildContext context, MenuOverview menuHistory) {
  return InkWell(
    onTap: () {
      Navigation.intentWithData(
        DetailOrderPage.routeName,
        menuHistory.idOrder,
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(menuHistory.menu[0].foto),
                ),
                color: const Color.fromRGBO(223, 223, 223, 1)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusOrder(menuHistory),
                      Text(
                        convertDate(menuHistory.tanggal.toString(), 'dd MMM yyyy'),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color.fromRGBO(170, 170, 170, 1),
                        ),
                      )
                    ],
                  ),
                  Text(
                    'nama',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        menuHistory.totalBayar.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: Text(
                          '(3) Menu',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: const Color.fromRGBO(170, 170, 170, 1),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Row _buildStatusOrder(MenuOverview menuHistory) {
  IconData icon;
  String teks;
  Color color;
  if (menuHistory.status == 0) {
    icon = Icons.access_time;
    color = const Color.fromRGBO(255, 172, 1, 1);
    teks = 'Dalam Antrian';
  } else if (menuHistory.status == 1) {
    icon = Icons.access_time;
    color = const Color.fromRGBO(255, 172, 1, 1);
    teks = 'Sedang Disiapkan';
  } else if (menuHistory.status == 2) {
    icon = Icons.check;
    color = const Color.fromRGBO(0, 156, 72, 1);
    teks = 'Bisa Diambil';
  } else if (menuHistory.status == 3) {
    icon = Icons.check;
    color = const Color.fromRGBO(0, 156, 72, 1);
    teks = 'Selesai';
  } else {
    icon = Icons.close;
    color = const Color.fromRGBO(230, 33, 41, 1);
    teks = 'Dibatalkan';
  }
  return Row(
    children: [
      Icon(
        icon,
        color: color,
        size: 16,
      ),
      Container(
        margin: const EdgeInsets.only(left: 4),
        child: Text(
          teks,
          style: GoogleFonts.montserrat(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ],
  );
}
