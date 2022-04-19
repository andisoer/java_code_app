import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/provider/order_history_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:java_code_app/widget/item_order_history.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var _selectedOrderType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Visibility(
              visible: _selectedOrderType == 2 ? true : false,
              child: _buildFilter(),
            ),
            Visibility(
              visible: _selectedOrderType == 1 ? true : false,
              child: _buildOrderList(),
            ),
            Visibility(
              visible: _selectedOrderType == 2 ? true : false,
              child: _buildOrderHistory(),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildOrderList() {
    return Expanded(
      child: Consumer<OrderHistoryProvider>(
        builder: (context, state, _) {
          if (state.resourceState == ResourceState.loading) {
            return const Text('loading');
          } else if (state.resourceState == ResourceState.hasData) {
            var count = state.orderList.data.length;
            return SingleChildScrollView(
              child: ListView.builder(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var menuHistory = state.orderList.data[index];

                  return buildItemOrderHistory(context, menuHistory);
                },
                itemCount: count,
              ),
            );
          } else if (state.resourceState == ResourceState.noData) {
            return const Text('empty');
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }

  Expanded _buildOrderHistory() {
    return Expanded(
      child: Consumer<OrderHistoryProvider>(
        builder: (context, state, _) {
          if (state.resourceState == ResourceState.loading) {
            return const Text('loading');
          } else if (state.resourceState == ResourceState.hasData) {
            var count = state.orderHistory.data.length;
            return SingleChildScrollView(
              child: ListView.builder(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var menuHistory = state.orderHistory.data[index];

                  return buildItemOrderHistory(context, menuHistory);
                },
                itemCount: count,
              ),
            );
          } else if (state.resourceState == ResourceState.noData) {
            return const Text('empty');
          } else {
            return const Text('error');
          }
        },
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
          InkWell(
            onTap: () {
              setState(() {
                _selectedOrderType = 1;
              });
            },
            child: Container(
              decoration: _selectedOrderType == 1
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: primaryColor, width: 3),
                      ),
                    )
                  : const BoxDecoration(),
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                'Sedang Berjalan',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: _selectedOrderType == 1 ? primaryColor : Colors.black,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedOrderType = 2;
              });
            },
            child: Container(
              decoration: _selectedOrderType == 2
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: primaryColor, width: 3),
                      ),
                    )
                  : const BoxDecoration(),
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                'Riwayat',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: _selectedOrderType == 2 ? primaryColor : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
