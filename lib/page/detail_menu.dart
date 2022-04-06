import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/data/model/menu_detail_result.dart';
import 'package:java_code_app/provider/menu_detail_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:provider/provider.dart';

class DetailMenuPage extends StatefulWidget {
  static const routeName = 'detailMenu';
  const DetailMenuPage({Key? key}) : super(key: key);

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
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
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Detail Menu',
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
            _buildMenuDetailInformation(context),
          ],
        ),
      ),
    );
  }

  Consumer<MenuDetailProvider> _buildMenuDetailInformation(
      BuildContext context) {
    return Consumer<MenuDetailProvider>(
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
          var menu = state.menuDetailResult.data;
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: Image.network(
                      menu.menu.foto,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Text(
                                        menu.menu.nama,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      child: Text(menu.menu.deskripsi),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      side: BorderSide(
                                        width: 2,
                                        color: primaryColor,
                                      ),
                                    ),
                                    child: const Icon(Icons.remove),
                                  ),
                                  Text(
                                    '1',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      backgroundColor: primaryColor,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        _buildMoneyInformation(menu),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        _builtLevelInformation(context),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        _builtToppingInformation(context),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        _builtNoteInformation(context),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Tambahkan Ke Pesanan",
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
                                color: Color.fromARGB(
                                  255,
                                  0,
                                  113,
                                  127,
                                ),
                                width: 1,
                              ),
                            ),
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
                ],
              ),
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

  Row _buildMoneyInformation(Data menu) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/money.png'),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            child: Text(
              'Harga',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Text(
          menu.menu.harga.toString(),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  InkWell _builtLevelInformation(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomSheet(
          elevation: 24,
          context: context,
          builder: (context) {
            return _showBottomSheetLevel();
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/level.png'),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                'Level',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                '1',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
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
        ],
      ),
    );
  }

  InkWell _builtToppingInformation(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomSheet(
          elevation: 24,
          context: context,
          builder: (context) {
            return _showBottomSheetTopping();
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/topping.png'),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                'Toping',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                'Mozarella',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
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
        ],
      ),
    );
  }

  InkWell _builtNoteInformation(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomSheet(
          elevation: 24,
          context: context,
          builder: (context) {
            return _showBottomSheetNote();
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/add_note.png'),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                'Catatan',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                'Lorem Ipsum',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
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
        ],
      ),
    );
  }

  Wrap _showBottomSheetLevel() {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  'Pilih Level',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    _buildItemChip(text: '1', selected: true),
                    _buildItemChip(text: '2', selected: false),
                    _buildItemChip(text: '3', selected: false),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container _buildItemChip({required String text, required bool selected}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: selected ? primaryColor : Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
        border: Border.all(color: selected ? Colors.transparent : primaryColor),
      ),
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: selected ? Colors.white : Colors.black),
          ),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: selected
                ? const Icon(
                    Icons.check,
                    size: 18,
                    color: Colors.white,
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  Wrap _showBottomSheetTopping() {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  'Pilih Topping',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Wrap(
                  children: [
                    _buildItemChip(text: 'Toping1', selected: true),
                    _buildItemChip(text: 'Toping2', selected: false),
                    _buildItemChip(text: 'Toping3', selected: false),
                    _buildItemChip(text: 'Toping4', selected: false),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Wrap _showBottomSheetNote() {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  'Buat Catatan',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      maxLength: 100,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.grey.withAlpha(100)
                        )
                      ]
                    ),
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(Icons.check),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
