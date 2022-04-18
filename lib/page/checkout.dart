import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/page/bottom_navigation_main.dart';
import 'package:java_code_app/page/voucher.dart';
import 'package:java_code_app/provider/auth_provider.dart';
import 'package:java_code_app/provider/discount_provider.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/provider/order_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:java_code_app/widget/item_list_all_menu.dart';
import 'package:pinput/pinput.dart';
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
            _builtAppBar(context),
            _buildMenuList(),
            _builtBottomContainer(),
          ],
        ),
      ),
    );
  }

  Container _builtBottomContainer() {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
      ),
      child: Column(
        children: [
          _buildTotalOrderInformation(),
          Consumer<MenuProvider>(
            builder: (context, state, _) {
              if (!state.isVoucherUsed) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: const Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                    _buildDiscountAmountInformation(context)
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
         buildHorizontalBorder(),
          _buildVoucherAmountInformation(),
          buildHorizontalBorder(),
          _buildPaymentInformation(),
          _buildTotalPaymentInformation()
        ],
      ),
    );
  }

  Container _builtAppBar(BuildContext context) {
    return Container(
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
                    Consumer<AuthProvider>(
                      builder: (context, state, _) {
                        if (state.isBioAuthenticated) {
                          WidgetsBinding.instance?.addPostFrameCallback(
                            (timeStamp) {
                              createOrder();
                            },
                          );
                        }
                        return Consumer<OrderProvider>(
                          builder: (context, state, _) {
                            Widget widget;
                            bool pressable = false;
                            if (state.resourceState ==
                                OrderResourceState.loading) {
                              pressable = false;
                              widget = const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            } else if (state.resourceState ==
                                OrderResourceState.success) {
                              pressable = true;
                              widget = Text(
                                'Pesan Sekarang',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              );
                              WidgetsBinding.instance?.addPostFrameCallback(
                                (timeStamp) {
                                  showOrderSuccessDialog();
                                },
                              );
                            } else if (state.resourceState ==
                                OrderResourceState.error) {
                              pressable = true;
                              widget = Text(
                                'Pesan Sekarang',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              );
                            } else {
                              pressable = true;
                              widget = Text(
                                'Pesan Sekarang',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (pressable) {
                                  checkout();
                                }
                              },
                              child: widget,
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
                            );
                          },
                        );
                      },
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

  InkWell _buildVoucherAmountInformation() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, VoucherPage.routeName);
      },
      child: Container(
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
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<MenuProvider>(
                    builder: (context, state, _) {
                      if (state.isVoucherUsed) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              state.voucherUsed.nominal.toString(),
                              style: GoogleFonts.montserrat(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.voucherUsed.nama.toString(),
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 46, 46, 46),
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text(
                          'Pilih Voucher',
                          style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 46, 46, 46),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        );
                      }
                    },
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
      ),
    );
  }

  Container _buildDiscountAmountInformation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<DiscountProvider>(
        builder: (context, state, _) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/discount_primary.png'),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Text(
                  'Diskon ' + state.totalDiscount.toString() + '%',
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
          );
        },
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

  void checkout() {
    showAuthenticateDialog();
  }

  void showAuthenticateDialog() {
    AlertDialog authenticateDialog = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verifikasi Pesanan',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              'Finger Print',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: const Color.fromRGBO(150, 150, 150, 1),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).authenticate();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Image.asset('assets/images/finger_print.png'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Divider(
                      color: Color.fromARGB(70, 30, 30, 30),
                      height: 1,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "atau",
                  style: TextStyle(
                    color: Color.fromARGB(70, 30, 30, 30),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: const [
                    Divider(
                      color: Color.fromARGB(70, 30, 30, 30),
                      height: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showPinDialog();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                'Verifikasi Menggunakan PIN',
                style: GoogleFonts.montserrat(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return authenticateDialog;
      },
    );
  }

  void showPinDialog() {
    var pin = getUserPin();
    pin.toString();
    final pinFieldTheme = PinTheme(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 36,
      height: 36,
      textStyle:
          GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: primaryColor),
      ),
    );

    showDialog(
      context: (context),
      builder: (BuildContext context) {
        bool _isPasswordVisible = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Verifikasi Pesanan',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Masukkan kode PIN',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color.fromRGBO(150, 150, 150, 1),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color.fromARGB(70, 0, 0, 0),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Pinput(
                        defaultPinTheme: pinFieldTheme,
                        validator: (s) {
                          return s == pin ? null : 'Pin is incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) {
                          Navigator.pop(context);
                          createOrder();
                        },
                        length: 6,
                        separatorPositions: const [2, 4],
                        separator: const Text('-'),
                        obscuringCharacter: '*',
                        obscureText: _isPasswordVisible,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void createOrder() {
    var isVoucherUsed =
        Provider.of<MenuProvider>(context, listen: false).isVoucherUsed;
    int? voucherId;
    if (isVoucherUsed) {
      voucherId = Provider.of<MenuProvider>(context, listen: false)
          .voucherUsed
          .idVoucher;
    }
    var totalDiscount =
        Provider.of<MenuProvider>(context, listen: false).totalDiscountNominal;
    var totalPayment =
        Provider.of<MenuProvider>(context, listen: false).totalPayment;
    var menuAddedList =
        Provider.of<MenuProvider>(context, listen: false).menuAddedList;

    Provider.of<OrderProvider>(context, listen: false).createOrder(
      totalPayment: totalPayment,
      menuAddedList: menuAddedList,
      discount: totalDiscount,
      voucherId: voucherId,
    );
  }

  void showOrderSuccessDialog() {
    AlertDialog orderSuccessDialog = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Image.asset('assets/images/order_success.png'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Text(
              'Pesanan Sedang Disiapkan',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 22,
                color: const Color.fromRGBO(30, 30, 30, 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              'Kamu dapat melacak pesananmu di fitur Pesanan',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: const Color.fromRGBO(46, 46, 46, 0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(BottomNavigationMain.routeName),
                );
              },
              child: Text(
                'Oke',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
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
            ),
          )
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return orderSuccessDialog;
      },
    );
  }
}
