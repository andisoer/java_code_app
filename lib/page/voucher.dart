import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/common/navigation.dart';
import 'package:java_code_app/data/model/voucher_result.dart';
import 'package:java_code_app/page/detail_voucher.dart';
import 'package:java_code_app/page/no_internet.dart';
import 'package:java_code_app/provider/internet_connection_provider.dart';
import 'package:java_code_app/provider/voucher_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:provider/provider.dart';

class VoucherPage extends StatefulWidget {
  static const routeName = 'voucher';
  const VoucherPage({Key? key}) : super(key: key);

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
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
                        Image.asset('assets/images/ticket_primary.png'),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Voucher',
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
            Expanded(
              child: Container(
                height: 170,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Consumer<VoucherProvider>(
                  builder: (context, state, _) {
                    if (state.resourceState == ResourceState.hasData) {
                      return ListView.builder(
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var voucher = state.voucherResult.data[index];

                          return _buildItemVoucher(context, voucher, index);
                        },
                        itemCount: state.voucherResult.data.length,
                      );
                    } else if (state.resourceState == ResourceState.noData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/empty_data.png'),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Belum ada voucher untuk anda :(',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    } else if (state.resourceState == ResourceState.error) {
                      return const Text('error');
                    } else if (state.resourceState == ResourceState.loading) {
                      return const Text('loading');

                      // return SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   clipBehavior: Clip.none,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   child: Row(
                      //     children: [],
                      //   ),
                      // );
                    } else {
                      return const Text('something wrong');
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

  InkWell _buildItemVoucher(BuildContext context, Voucher voucher, int index) {
    return InkWell(
      onTap: () {
        isInternetConnected().then((internetConnected) {
          if (internetConnected) {
            Navigation.intentWithData(
                DetailVoucherPage.routeName, voucher.idVoucher!);
          } else {
            Navigator.pushNamed(context, NoInternetPage.routeName);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          color: Color.fromRGBO(246, 246, 246, 1),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    voucher.nama.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      checkColor: primaryColor,
                      activeColor: Colors.transparent,
                      value: voucher.isSelected,
                      onChanged: (bool? value) {
                        Provider.of<VoucherProvider>(context, listen: false)
                            .selectVoucher(index);
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 46, 46, 46),
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    voucher.infoVoucher.toString(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
