import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sambapos_menu/models/item_model.dart';
import 'package:sambapos_menu/models/yaml_model.dart';
import 'package:yaml/yaml.dart';

class MenuProvider extends ChangeNotifier {
  bool loading = false;
  List<Item> menuItems = [];
  Item discountMenuItems = Item();

  List<Item> basket = [];

  Future getMenus() async {
    loading = true;
    final data = await rootBundle.loadString("assets/menu.yaml");
    final yamlData = loadYaml(data);
    // print(json.encode(yamlData));
    final jsonData = json.decode(json.encode(yamlData));
    // print(jsonData.runtimeType);

    YamlModel yamlModel = YamlModel.fromJson(jsonData);
    // print(yamlModel.menus);

    sleep(Duration(seconds: 1));

    menuItems = yamlModel.menus!.first.items!;
    discountMenuItems = yamlModel.menus!.first.items!.first;

    menuItems.removeAt(0);

    loading = false;
    // print(menuItems);

    notifyListeners();
  }

  addToBasket(Item item) {
    basket.add(item);
    notifyListeners();
    print(basket);
  }

  removeFromBasket(Item item) {
    basket.remove(item);
    notifyListeners();
    print(basket);
  }
}
