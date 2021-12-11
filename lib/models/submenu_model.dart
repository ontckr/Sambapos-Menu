import 'package:sambapos_menu/models/item_model.dart';

class SubMenu {
  SubMenu({
    required this.key,
    this.description,
    this.orderTag,
    this.items,
  });

  String key;
  String? description;
  String? orderTag;
  List<Item>? items;

  factory SubMenu.fromJson(Map<String, dynamic> json) => SubMenu(
        key: json["key"],
        description: json["description"],
        orderTag: json["orderTag"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "description": description,
        "orderTag": orderTag,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
