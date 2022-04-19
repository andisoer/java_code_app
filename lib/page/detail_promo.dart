import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/data/model/promo_result.dart';
import 'package:java_code_app/provider/promo_detail_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:provider/provider.dart';

class DetailPromoPage extends StatefulWidget {
  static const routeName = 'detailPromo';

  const DetailPromoPage({Key? key}) : super(key: key);

  @override
  State<DetailPromoPage> createState() => _DetailPromoPageState();
}

class _DetailPromoPageState extends State<DetailPromoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 66,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: appBarDecoration(context),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ticket_primary.png'),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Promo',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildPromoInformation(),
          ],
        ),
      ),
    );
  }

  Consumer<PromoDetailProvider> _buildPromoInformation() {
    return Consumer<PromoDetailProvider>(
      builder: (context, state, _) {
        if (state.resourceState == ResourceState.loading) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        } else if (state.resourceState == ResourceState.hasData) {
          Promo promo = state.promoResult.promo;
          return Expanded(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  width: MediaQuery.of(context).size.width,
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
                            Text(
                              promo.nama ?? 'nama',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                                fontSize: 14,
                              ),
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
                    image: promo.foto != null && promo.foto!.trim().isNotEmpty
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(top: 8),
                    height: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                promo.nama ?? 'nama_promo',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Text(
                              promo.diskon != null
                                  ? 'Diskon ' + promo.diskon.toString() + '%'
                                  : '0%',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        buildHorizontalBorder(margin: const EdgeInsets.symmetric(vertical: 16)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/list_primary.png'),
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Syarat dan ketentuan',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Html(data: promo.syaratKetentuan),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state.resourceState == ResourceState.error) {
          return const Center(
            child: Text('error'),
          );
        } else {
          return const Center(
            child: Text('error'),
          );
        }
      },
    );
  }
}
