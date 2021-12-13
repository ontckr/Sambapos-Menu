import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sambapos_menu/models/item_model.dart';
import 'package:sambapos_menu/models/menu_model.dart';
import 'package:sambapos_menu/models/yaml_model.dart';
import 'package:yaml/yaml.dart';

class MenuProvider extends ChangeNotifier {
  late YamlModel yamlModel;
  bool loading = false;

  List<Item> menuItems = [];
  Item discountMenuItems = Item();
  List<Item> basket = [];
  double basketPrice = 0;

  List<Menu> subMenu = [];
  Map<String, Item> selectedSubMenuItems = {};

  double basePrice = 0;
  double updatedBasePrice = 0;

  late Item selectedSubMenu;

  Future getMenus() async {
    loading = true;
    final data = await rootBundle.loadString("assets/menu.yaml");
    final yamlData = loadYaml(data);
    // print(json.encode(yamlData));
    final jsonData = json.decode(json.encode(yamlData));
    // print(jsonData.runtimeType);
    yamlModel = YamlModel.fromJson(jsonData);
    // print(yamlModel.menus);
    await Future.delayed(Duration(seconds: 1));

    menuItems = yamlModel.menus!.first.items!;
    discountMenuItems = yamlModel.menus!.first.items!.first;

    menuItems.removeAt(0);
    loading = false;
    notifyListeners();
  }

  addToBasket(Item item) {
    basket.add(item);
    basketPrice += item.price ?? 0;
    notifyListeners();
  }

  List<Menu> getSubMenu(List<String> subMenuKeys) {
    subMenu = [];
    for (var menuKey in subMenuKeys) {
      var key = yamlModel.menus!.firstWhere((element) => element.key == menuKey);
      subMenu.add(key);
    }
    return subMenu;
  }

  addToSelection(String subMenuKey, Item item) {
    selectedSubMenuItems[subMenuKey] = item;
    updatedBasePrice = basePrice;
    selectedSubMenuItems.forEach((k, v) {
      updatedBasePrice += v.price ?? 0;
    });
    notifyListeners();
  }

  selectMenu(Item item) {
    selectedSubMenu = item;
    basePrice = item.price ?? 0;
    updatedBasePrice = basePrice;
    selectedSubMenuItems = {};
    notifyListeners();
  }

  bool addSelectionsToBasket() {
    if (selectedSubMenu.subMenus!.length != selectedSubMenuItems.keys.length) {
      return false;
    }
    selectedSubMenuItems.forEach((k, v) {
      basket.add(v);
    });
    basketPrice += updatedBasePrice;
    notifyListeners();
    return true;
  }
}
