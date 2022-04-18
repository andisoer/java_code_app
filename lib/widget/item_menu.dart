import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/common/navigation.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:java_code_app/page/detail_menu.dart';
import 'package:java_code_app/page/no_internet.dart';
import 'package:java_code_app/provider/internet_connection_provider.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:provider/provider.dart';

InkWell buildItemMenu(BuildContext context, Menu menu) {
  return InkWell(
    onTap: () {
      isInternetConnected().then((internetConnected) {
        if (internetConnected) {
          Navigation.intentWithData(DetailMenuPage.routeName, menu.idMenu);
        } else {
          Navigator.pushNamed(context, NoInternetPage.routeName);
        }
      });
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(menu.foto ?? '')),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    menu.harga.toString(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/add_note.png'),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: Text(
                            menu.catatan.isNotEmpty
                                ? menu.catatan
                                : 'Tambahkan catatan',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: const Color.fromARGB(255, 170, 170, 170),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: menu.jumlah > 0 ? true : false,
                  child: TextButton(
                    onPressed: () {
                      Provider.of<MenuProvider>(
                        context,
                        listen: false,
                      ).removeMenuCount(menu.idMenu);
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
                ),
                Text(
                  menu.jumlah.toString(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<MenuProvider>(context, listen: false)
                        .addMenuCount(menu.idMenu);

                    if (menu.jumlah == 1) {
                      WidgetsBinding.instance?.addPostFrameCallback(
                        (timeStamp) {
                          Navigation.intentWithData(
                            DetailMenuPage.routeName,
                            menu.idMenu,
                          );
                        },
                      );
                    }
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
          )
        ],
      ),
    ),
  );
}
