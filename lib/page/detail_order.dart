import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:java_code_app/provider/order_history_detail_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:java_code_app/widget/item_list_all_menu.dart';
import 'package:provider/provider.dart';

class DetailOrderPage extends StatefulWidget {
  static const routeName = 'detailOrder';
  const DetailOrderPage({Key? key}) : super(key: key);

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTotalOrderInformation(),
          Column(
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
          ),
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: const Divider(
              height: 2,
              color: Colors.grey,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Pesanan kamu sedang disiapkan',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _buildOrderStatusStepper(),
          _buildOrderStatusDescription(),
        ],
      ),
    );
  }

  Container _buildOrderStatusDescription() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1 / 7,
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              'Pesanan Diterima',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1 / 7,
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              'Silahkan Diambil',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width * 1 / 7,
            child: Text(
              'Pesanan Selesai',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildOrderStatusStepper() {
    return Container(
      margin: const EdgeInsets.only(left: 34, right: 34, top: 16),
      child: Consumer<OrderHistoryDetailProvider>(
        builder: (context, state, _) {
          if (state.resourceState == ResourceState.hasData) {
            var statusOrder = state.orderHistoryDetailResult.data.order.status;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                statusOrder == 0 || statusOrder == 1
                    ? Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 2,
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          size: 24,
                          color: primaryColor,
                        ),
                      )
                    : const Icon(
                        Icons.circle,
                        size: 12,
                        color: Color.fromARGB(70, 30, 30, 30),
                      ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: const [
                        Divider(
                          color: Color.fromARGB(70, 30, 30, 30),
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                statusOrder == 2
                    ? Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 2,
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          size: 24,
                          color: primaryColor,
                        ),
                      )
                    : const Icon(
                        Icons.circle,
                        size: 12,
                        color: Color.fromARGB(70, 30, 30, 30),
                      ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: const [
                        Divider(
                          color: Color.fromARGB(70, 30, 30, 30),
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                statusOrder == 3
                    ? Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 2,
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          size: 24,
                          color: primaryColor,
                        ),
                      )
                    : const Icon(
                        Icons.circle,
                        size: 12,
                        color: Color.fromARGB(70, 30, 30, 30),
                      )
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.circle,
                  size: 12,
                  color: Color.fromARGB(70, 30, 30, 30),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: const [
                        Divider(
                          color: Color.fromARGB(70, 30, 30, 30),
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.circle,
                  size: 12,
                  color: Color.fromARGB(70, 30, 30, 30),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: const [
                        Divider(
                          color: Color.fromARGB(70, 30, 30, 30),
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.circle,
                  size: 12,
                  color: Color.fromARGB(70, 30, 30, 30),
                )
              ],
            );
          }
        },
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
      onTap: () {},
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'nominal',
                        style: GoogleFonts.montserrat(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'nama',
                        style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 46, 46, 46),
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Pilih Voucher',
                    style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 46, 46, 46),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
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
      ),
    );
  }

  Container _buildDiscountAmountInformation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/discount_primary.png'),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Text(
              'Diskon 40%',
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
      child: Consumer<OrderHistoryDetailProvider>(
        builder: (context, state, _) {
          if (state.resourceState == ResourceState.hasData) {
            var data = state.orderHistoryDetailResult.data;
            return Row(
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
                    child: Text(
                      '(3 menu)',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400, fontSize: 16),
                    )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Rp ${data.order.totalBayar}',
                        style: GoogleFonts.montserrat(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Row(
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
                    child: Text(
                      '(3 menu)',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400, fontSize: 16),
                    )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Rp 40.000',
                        style: GoogleFonts.montserrat(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Consumer<OrderHistoryDetailProvider> _buildMenuList() {
    return Consumer<OrderHistoryDetailProvider>(
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
          var menuOrderList = state.orderHistoryDetailResult.data.detail;
          if (menuOrderList.isNotEmpty) {
            List<MenuListItem> allMenuList = [];
            List<MenuListItem> foodMenuList = [];
            List<MenuListItem> drinkMenuList = [];

            for (int i = 0; i < menuOrderList.length; i++) {
              var item = menuOrderList[i];
              Menu menu = Menu(
                idMenu: item.idMenu,
                nama: item.nama,
                kategori: item.kategori,
                harga: int.parse(item.harga!),
                deskripsi: '',
                foto: item.foto,
                status: 0,
              );
              if (item.kategori == 'makanan') {
                foodMenuList.add(
                  MenuItem(
                    menu,
                  ),
                );
              } else {
                drinkMenuList.add(
                  MenuItem(
                    menu,
                  ),
                );
              }
            }

            if (foodMenuList.isNotEmpty) {
              foodMenuList.insert(
                0,
                MenuCategoryItem('Makanan', 'assets/images/food_primary.png'),
              );
            }

            if (drinkMenuList.isNotEmpty) {
              drinkMenuList.insert(
                0,
                MenuCategoryItem('Minuman', 'assets/images/coffe_primary.png'),
              );
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
                    'Tidak ada data',
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
        } else {
          return const Text('error');
        }
      },
    );
  }
}
