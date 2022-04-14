import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/common/navigation.dart';
import 'package:java_code_app/data/model/order_history_result.dart';
import 'package:java_code_app/page/detail_order.dart';
import 'package:java_code_app/provider/internet_connection_provider.dart';
import 'package:java_code_app/provider/order_history_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            _buildFilter(),
            Expanded(
              child: Container(
                child: Consumer<OrderHistoryProvider>(
                  builder: (context, state, _) {
                    if (state.resourceState == ResourceState.loading) {
                      return const Text('loading');
                    } else if (state.resourceState == ResourceState.hasData) {
                      return ListView.builder(
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var menuHistory =
                              state.orderHistoryResult.data[index];

                          return _buildItemOrderHistory(context, menuHistory);
                        },
                        itemCount: state.orderHistoryResult.data.length,
                      );
                    } else {
                      return const Text('error');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _buildItemOrderHistory(
      BuildContext context, MenuOverview menuHistory) {
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
              height: 100,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('menu.foto'),
                  ),
                  color: Color.fromRGBO(223, 223, 223, 1)),
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
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Color.fromRGBO(0, 156, 72, 1),
                              size: 16,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: Text(
                                'Selesai',
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 156, 72, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          '20 Des 2021',
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
                          'harga',
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

  Container _buildFilter() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              color: const Color.fromRGBO(246, 246, 246, 1),
            ),
            child: Row(
              children: [
                Text(
                  'Semua Status',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              color: const Color.fromRGBO(246, 246, 246, 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '25/12/21 - 30/12/21',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color.fromRGBO(170, 170, 170, 1)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    'assets/images/calendar_outlined_primary.png',
                    scale: 0.65,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: appBarDecoration(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Sedang Berjalan',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Riwayat',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
