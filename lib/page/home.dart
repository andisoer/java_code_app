import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code_app/data/model/menu_category.dart';
import 'package:java_code_app/provider/menu_provider.dart';
import 'package:java_code_app/provider/promo_provider.dart';
import 'package:java_code_app/style/colors.dart';
import 'package:java_code_app/style/style.dart';
import 'package:java_code_app/widget/item_list_all_menu.dart';
import 'package:java_code_app/widget/item_promo.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuCategory> categoryList = [
    MenuCategory('Semua Makanan', 'assets/images/list.png', true, 'all'),
    MenuCategory('Makanan', 'assets/images/food_white.png', true, 'makanan'),
    MenuCategory('Minuman', 'assets/images/coffe_white.png', true, 'minuman')
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 66,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              decoration: appBarDecoration(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/ticket_primary.png'),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Promo yang tersedia',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    _buildPromoList(context),
                    _buildCategoryList(),
                    _buildMenuList()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Consumer<MenuProvider> _buildMenuList() {
    return Consumer<MenuProvider>(
      builder: (context, state, _) {
        if (state.resourceState == MenuResourceState.hasData) {
          List<MenuListItem> allMenuList = [];
          List<MenuListItem> foodMenuList = [];
          List<MenuListItem> drinkMenuList = [];
        
          for (int i = 0; i < state.menuResult.data.length; i++) {
            var item = state.menuResult.data[i];
            if (item.kategori == 'makanan') {
              foodMenuList.add(
                MenuItem(
                  state.menuResult.data[i],
                ),
              );
            } else {
              drinkMenuList.add(
                MenuItem(
                  state.menuResult.data[i],
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

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = allMenuList[index];
              return item.buildItemWidget(context);
            },
            itemCount: allMenuList.length,
          );
        } else if (state.resourceState == MenuResourceState.noData) {
          return const Text('empty');
        } else if (state.resourceState == MenuResourceState.error) {
          return const Text('error');
        } else if (state.resourceState == MenuResourceState.loading) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildMenuShimmer(),
                _buildMenuShimmer(),
                _buildMenuShimmer(),
              ],
            ),
          );
        } else {
          return const Text('something wrong');
        }
      },
    );
  }

  Container _buildCategoryList() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 8),
      child: ListView.builder(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final item = categoryList[index];
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              var type = item.slug;
              Provider.of<MenuProvider>(context, listen: false).fetchMenu(
                type: type,
              );
            },
            child: _buildCategoryItem(
              item.name,
              selectedIndex == index ? true : false,
              item.assetImage,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Container _buildCategoryItem(
    String categoryName,
    bool selected,
    String imageAsset,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: selected ? const Color.fromARGB(255, 46, 46, 46) : primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 2,
            color: Colors.grey.withAlpha(70),
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Image.asset(imageAsset),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Text(
              categoryName,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildPromoList(BuildContext context) {
    return Container(
      height: 170,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<PromoProvider>(
        builder: (context, state, _) {
          if (state.resourceState == ResourceState.hasData) {
            return ListView.builder(
              clipBehavior: Clip.none,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return itemPromo(context, state.promoResult.data[index]);
              },
              itemCount: state.promoResult.data.length,
            );
          } else if (state.resourceState == ResourceState.noData) {
            return const Text('empty');
          } else if (state.resourceState == ResourceState.error) {
            return const Text('error');
          } else if (state.resourceState == ResourceState.loading) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [
                  _buildPromoShimmer(context),
                  _buildPromoShimmer(context),
                ],
              ),
            );
          } else {
            return const Text('something wrong');
          }
        },
      ),
    );
  }

  Shimmer _buildPromoShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.withAlpha(70),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: MediaQuery.of(context).size.width * 3 / 4,
        height: 170,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          child: Stack(
            children: [
              Container(
                color: primaryColor.withAlpha(230),
              ),
            ],
          ),
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }

  Shimmer _buildMenuShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.withAlpha(70),
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
              height: 75,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
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
                      'lorem ipsum',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'rp 20000',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/add_note.png'),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 4),
                            child: Text(
                              'Tambahkan catatan',
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
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
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      side: const BorderSide(
                        width: 2,
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
}
