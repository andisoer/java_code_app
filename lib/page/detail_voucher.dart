import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/common/utils.dart';
import 'package:java_code_app/data/model/voucher_result.dart';
import 'package:java_code_app/page/checkout.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/provider/voucher_detail_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:provider/provider.dart';

class DetailVoucherPage extends StatefulWidget {
  static const routeName = 'detailVoucher';

  const DetailVoucherPage({Key? key}) : super(key: key);

  @override
  State<DetailVoucherPage> createState() => _DetailVoucherPageState();
}

class _DetailVoucherPageState extends State<DetailVoucherPage> {
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
                        Text(
                          'Detail Voucher',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
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

  Consumer<VoucherDetailProvider> _buildPromoInformation() {
    return Consumer<VoucherDetailProvider>(
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
          Voucher voucher = state.voucherResult.data;
          return Expanded(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    image: voucher.infoVoucher != null &&
                            voucher.infoVoucher!.trim().isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(
                              voucher.infoVoucher!,
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(top: 8),
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 1 / 2,
                          child: Text(
                            voucher.nama ?? 'nama_promo',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          voucher.catatan != null ? voucher.catatan! : '-',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/calendar_outlined_primary.png',
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Valid Date',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    convertEpochToDate(
                                          voucher.periodeMulai!,
                                          'dd/MM/yyyy',
                                        ) +
                                        ' - ' +
                                        convertEpochToDate(
                                          voucher.periodeMulai!,
                                          'dd/MM/yyyy',
                                        ),
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
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
                ),
                Container(
                  child: Consumer<MenuProvider>(
                    builder: (context, state, _) {
                      var text = 'Pakai Voucher';
                      var currentVoucherUsed = false;
                      if (state.isVoucherUsed) {
                        if (state.voucherUsed.idVoucher == voucher.idVoucher) {
                          text = 'Batal Pakai Voucher';
                          currentVoucherUsed = true;
                        }
                      }
                      return ElevatedButton(
                        child: Text(
                          text,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          if (currentVoucherUsed) {
                            Provider.of<MenuProvider>(context, listen: false)
                                .unuseVoucher(voucher);
                          } else {
                            Provider.of<MenuProvider>(context, listen: false)
                                .useVoucher(voucher);

                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(CheckoutPage.routeName),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          primary: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size.fromHeight(40),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 0, 113, 127),
                            width: 1,
                          ),
                        ),
                      );
                    },
                  ),
                  padding: const EdgeInsets.only(
                      top: 12, left: 16, right: 16, bottom: 24),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 1,
                        color: Colors.grey.withAlpha(70),
                        offset: const Offset(0, -3),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
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
