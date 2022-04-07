import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/data/model/menu_result.dart';
import 'package:java_code_app/widget/item_menu.dart';
import 'package:java_code_app/widget/item_menu_category.dart';

abstract class MenuListItem {
  Widget buildItemWidget(BuildContext context);
}

class MenuCategoryItem implements MenuListItem {
  final String categoryName;
  final String imageAssets;

  MenuCategoryItem(this.categoryName, this.imageAssets);

  @override
  Widget buildItemWidget(BuildContext context) {
    return buildCategoryTitle(categoryName, imageAssets);
  }
}

class MenuItem implements MenuListItem {
  final Menu menu;

  MenuItem(this.menu);

  @override
  Widget buildItemWidget(BuildContext context) {
    return buildItemMenu(context, menu);
  }
}
