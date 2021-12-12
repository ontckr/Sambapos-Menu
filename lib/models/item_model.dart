class Item {
  Item({
    this.name,
    this.caption,
    this.price,
    this.subMenus,
    this.image,
    this.items,
  });

  String? name;
  String? caption;
  dynamic price;
  List<String>? subMenus;
  String? image;
  List<Item>? items;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        caption: json["caption"] == null ? null : json["caption"],
        price: json["price"] == null ? null : json["price"],
        subMenus: json["subMenus"] == null ? null : List<String>.from(json["subMenus"].map((x) => x)),
        image: json["image"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "caption": caption == null ? null : caption,
        "price": price == null ? null : price,
        "subMenus": subMenus == null ? null : List<dynamic>.from(subMenus!.map((x) => x)),
        "image": image,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

// caption, subMenus, price optional 