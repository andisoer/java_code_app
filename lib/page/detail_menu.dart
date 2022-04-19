import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/data/model/menu_detail_result.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:java_code_app/provider/menu_detail_provider.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class DetailMenuPage extends StatefulWidget {
  static const routeName = 'detailMenu';
  const DetailMenuPage({Key? key}) : super(key: key);

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  var note = "";
  late Level level;
  late Topping topping;

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
                      menu.menu.foto ?? '',
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
                                  Consumer<MenuProvider>(
                                    builder: (context, state, _) {
                                      Menu _menu = state.menuResult.data
                                          .firstWhere((item) =>
                                              item.idMenu == menu.menu.idMenu);
                                      return Visibility(
                                        visible:
                                            _menu.jumlah > 0 ? true : false,
                                        child: TextButton(
                                          onPressed: () {
                                            Provider.of<MenuProvider>(
                                              context,
                                              listen: false,
                                            ).removeMenuCount(menu.menu.idMenu);
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size.zero,
                                            side: BorderSide(
                                              width: 2,
                                              color: primaryColor,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: primaryColor,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Consumer<MenuProvider>(
                                    builder: (context, state, _) {
                                      Menu _menu = state.menuResult.data
                                          .firstWhere((item) =>
                                              item.idMenu == menu.menu.idMenu);
                                      return Text(
                                        _menu.jumlah.toString(),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      );
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<MenuProvider>(
                                        context,
                                        listen: false,
                                      ).addMenuCount(menu.menu.idMenu);
                                    },
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
                        buildHorizontalBorder(
                            margin: const EdgeInsets.symmetric(vertical: 16)),
                        _buildMoneyInformation(menu),
                        buildHorizontalBorder(
                            margin: const EdgeInsets.symmetric(vertical: 16)),
                        _builtLevelInformation(
                            context, menu.level, menu.menu.idMenu),
                        buildHorizontalBorder(
                            margin: const EdgeInsets.symmetric(vertical: 16)),
                        _builtToppingInformation(
                            context, menu.topping, menu.menu.idMenu),
                        buildHorizontalBorder(
                            margin: const EdgeInsets.symmetric(vertical: 16)),
                        _builtNoteInformation(context, menu.menu),
                        buildHorizontalBorder(
                            margin: const EdgeInsets.symmetric(vertical: 16)),
                        _updateButtonAddOrder(menu),
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

  Container _updateButtonAddOrder(Data menu) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ElevatedButton(
        onPressed: () {
          Provider.of<MenuProvider>(
            context,
            listen: false,
          ).addMenuCount(menu.menu.idMenu);
        },
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

  InkWell _builtLevelInformation(
      BuildContext context, List<Level> level, int menuId) {
    return InkWell(
      onTap: () {
        showBottomSheet(
          elevation: 24,
          context: context,
          builder: (context) {
            return _showBottomSheetLevel(level, menuId);
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
              Consumer<MenuProvider>(builder: (context, state, _) {
                var _menu = state.menuResult.data
                    .firstWhere((item) => item.idMenu == menuId);
                return Text(
                  _menu.level == null ? 'Pilih level' : _menu.level.toString(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                );
              }),
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

  InkWell _builtToppingInformation(
      BuildContext context, List<Topping> topping, int menuId) {
    return InkWell(
      onTap: () {
        showBottomSheet(
          elevation: 24,
          context: context,
          builder: (context) {
            return _showBottomSheetTopping(topping, menuId);
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
                'Topping',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Consumer<MenuProvider>(
                builder: (context, state, _) {
                  var text = 'Pilih Topping';
                  var _menu = state.menuResult.data
                      .firstWhere((item) => item.idMenu == menuId);
                  if (_menu.topping != null) {
                    text = '';
                    for (var i = 0; i < _menu.topping!.length; i++) {
                      var toppingAdded = topping.firstWhereOrNull(
                          (_topping) => _topping.idDetail == _menu.topping![i]);

                      if (toppingAdded != null) {
                        text += toppingAdded.keterangan + ', ';
                      }
                    }

                    if (_menu.topping!.isEmpty) {
                      text = 'Pilih Topping';
                    }
                  }

                  return Text(
                    text,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  );
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
        ],
      ),
    );
  }

  InkWell _builtNoteInformation(BuildContext context, Menu menu) {
    return InkWell(
      onTap: () {
        showBottomSheet(
          elevation: 24,
          context: context,
          builder: (context) {
            return _showBottomSheetNote(menu);
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
              Consumer<MenuProvider>(
                builder: (context, state, _) {
                  var _menu = state.menuResult.data
                      .firstWhere((item) => item.idMenu == menu.idMenu);
                  return Text(
                    _menu.catatan.isEmpty ? '-' : _menu.catatan,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  );
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
        ],
      ),
    );
  }

  Wrap _showBottomSheetLevel(List<Level> level, int menuId) {
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
                child: level.isNotEmpty
                    ? Wrap(
                        direction: Axis.horizontal,
                        children: [
                          for (var item in level)
                            InkWell(
                              onTap: () {
                                Provider.of<MenuProvider>(context,
                                        listen: false)
                                    .chooseLevel(menuId, item);
                              },
                              child: Consumer<MenuProvider>(
                                builder: (create, state, _) {
                                  var _menu = state.menuResult.data.firstWhere(
                                      (item) => item.idMenu == menuId);
                                  return _buildItemChip(
                                    text: item.keterangan,
                                    selected: _menu.level.toString() ==
                                            item.keterangan
                                        ? true
                                        : false,
                                  );
                                },
                              ),
                            )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Tidak ada level untuk menu ini',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
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

  Wrap _showBottomSheetTopping(List<Topping> topping, int menuId) {
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
              Consumer<MenuProvider>(
                builder: (context, state, _) {
                  var _menu = state.menuResult.data
                      .firstWhere((item) => item.idMenu == menuId);
                  List<int> _addedTopping = [];
                  if (_menu.topping != null) {
                    _addedTopping.addAll(_menu.topping!);
                  }

                  return Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: topping.isNotEmpty
                        ? Wrap(
                            direction: Axis.horizontal,
                            children: [
                              for (var _item in topping)
                                InkWell(
                                  onTap: () {
                                    var toppingId = _item.idDetail;
                                    Provider.of<MenuProvider>(context,
                                            listen: false)
                                        .chooseTopping(menuId, toppingId);
                                  },
                                  child: _buildItemChip(
                                    text: _item.keterangan,
                                    selected:
                                        _addedTopping.contains(_item.idDetail)
                                            ? true
                                            : false,
                                  ),
                                )
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                'Tidak ada topping untuk menu ini',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Wrap _showBottomSheetNote(Menu menu) {
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
                  Expanded(
                    child: Consumer<MenuProvider>(
                      builder: (context, state, _) {
                        var _menu = state.menuResult.data.firstWhereOrNull(
                            (item) => item.idMenu == menu.idMenu);
                        return TextField(
                          controller: TextEditingController()
                            ..text = _menu == null ? '' : _menu.catatan,
                          onChanged: (value) => note = value,
                          maxLength: 100,
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.grey.withAlpha(100),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          Provider.of<MenuProvider>(
                            context,
                            listen: false,
                          ).saveNote(
                            menu.idMenu,
                            note,
                          );
                        },
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
