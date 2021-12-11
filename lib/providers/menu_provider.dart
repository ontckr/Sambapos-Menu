import 'package:flutter/material.dart';
import 'package:sambapos_menu/models/menu_model.dart';

class MenuProvider extends ChangeNotifier {
  //! => menus(key=main)
  //! => submenu(key)
  //! => basket(list<item>)

  List<Menu> menu = [];

  Future<List<Menu>> getMenus() async {
    return menu;
  }
}
