import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:java_code_app/widget/item_list_all_menu.dart';
import 'package:java_code_app/widget/item_menu_shimmer.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  static const routeName = 'checkout';
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Image.asset('assets/images/sajen_primary.png'),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Pesanan',
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
            _buildMenuList(),
            Container(
              padding: const EdgeInsets.only(top: 24),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 246, 246, 246),
              ),
              child: Column(
                children: [
                  _buildTotalOrderInformation(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                  ),
                  _buildDiscountAmountInformation(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                  ),
                  _buildVoucherAmountInformation(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                  ),
                  _buildPaymentInformation(),
                  _buildTotalPaymentInformation()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildTotalPaymentInformation() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      margin: const EdgeInsets.only(top: 18),
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
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/images/cart_primary.png'),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: const Color.fromARGB(174, 46, 46, 46),
                      ),
                    ),
                    Consumer<MenuProvider>(
                      builder: (context, state, _) {
                        return Text(
                          'Rp ${state.totalPayment}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: primaryColor,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Pesan Sekarang',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                        primary: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 0, 113, 127),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildPaymentInformation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/balance_outline_primary.png'),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Text(
              'Pembayaran',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Pay Later',
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 46, 46, 46),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildVoucherAmountInformation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/voucher_outline_primary.png'),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Text(
              'Voucher',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Pilih Voucher',
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 46, 46, 46),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildDiscountAmountInformation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/discount_primary.png'),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Text(
              'Diskon 20%',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Rp 4.000',
                  style: GoogleFonts.montserrat(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildTotalOrderInformation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Pesanan',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: Consumer<MenuProvider>(
              builder: (context, state, _) {
                return Text(
                  '(${state.menuTotal} menu)',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, fontSize: 16),
                );
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<MenuProvider>(
                  builder: (context, state, _) {
                    return Text(
                      'Rp ${state.priceTotal}',
                      style: GoogleFonts.montserrat(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Consumer<MenuProvider> _buildMenuList() {
    return Consumer<MenuProvider>(
      builder: (context, state, _) {
        if (state.menuAddedList.isNotEmpty) {
          List<MenuListItem> allMenuList = [];
          List<MenuListItem> foodMenuList = [];
          List<MenuListItem> drinkMenuList = [];

          print(jsonEncode(state.menuAddedList));

          for (int i = 0; i < state.menuAddedList.length; i++) {
            var item = state.menuAddedList[i];
            if (item.kategori == 'makanan') {
              foodMenuList.add(
                MenuItem(
                  state.menuAddedList[i],
                ),
              );
            } else {
              drinkMenuList.add(
                MenuItem(
                  state.menuAddedList[i],
                ),
              );
            }
          }

          if (foodMenuList.isNotEmpty) {
            foodMenuList.insert(0,
                MenuCategoryItem('Makanan', 'assets/images/food_primary.png'));
          }

          if (drinkMenuList.isNotEmpty) {
            drinkMenuList.insert(0,
                MenuCategoryItem('Minuman', 'assets/images/coffe_primary.png'));
          }

          allMenuList.addAll(foodMenuList);
          allMenuList.addAll(drinkMenuList);

          return Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = allMenuList[index];
                  return item.buildItemWidget(context);
                },
                itemCount: allMenuList.length,
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 3,
                child: Text(
                  'Belum ada menu yang anda pilih',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
