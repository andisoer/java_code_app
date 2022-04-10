import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/common/navigation.dart';
import 'package:java_code_app/data/model/promo_result.dart';
import 'package:java_code_app/page/detail_promo.dart';
import 'package:java_code_app/page/no_internet.dart';
import 'package:java_code_app/provider/internet_connection_provider.dart';
import 'package:java_code_app/style/colors.dart';

InkWell itemPromo(BuildContext context, Promo promo) {
  return InkWell(
    onTap: () {
      isInternetConnected().then((internetConnected) {
        if (internetConnected) {
          Navigation.intentWithData(DetailPromoPage.routeName, promo.idPromo!);
        } else {
          Navigator.pushNamed(context, NoInternetPage.routeName);
        }
      });
    },
    child: Container(
      margin: const EdgeInsets.only(right: 16),
      width: MediaQuery.of(context).size.width * 3 / 4,
      height: 170,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: Stack(
          children: [
            Container(
              color: primaryColor.withAlpha(230),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Diskon',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        promo.diskon != null
                            ? promo.diskon.toString() + '%'
                            : '0%',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        promo.nama ?? 'nama',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        image: promo.foto != null
            ? DecorationImage(
                image: NetworkImage(
                  promo.foto!,
                ),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage(
                  'assets/images/image_promo.png',
                ),
                fit: BoxFit.cover,
              ),
      ),
    ),
  );
}
