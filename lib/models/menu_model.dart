import 'item_model.dart';

class Menu {
  Menu({
    required this.key,
    this.description,
    this.items,
    this.orderTag,
  });

  String key;
  String? description;
  List<Item>? items;
  String? orderTag;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        key: json["key"],
        description: json["description"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        orderTag: json["orderTag"] == null ? null : json["orderTag"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "description": description,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "orderTag": orderTag == null ? null : orderTag,
    };
}


//orderTag optional