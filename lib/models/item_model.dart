class Item {
  Item({
    required this.name,
    this.caption,
    this.price,
    this.subMenus,
    this.image,
  });

  String name;
  String? caption;
  int? price;
  List<String>? subMenus;
  String? image;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        caption: json["caption"],
        price: json["price"],
        subMenus: List<String>.from(json["subMenus"].map((x) => x)),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "caption": caption,
        "price": price,
        "subMenus": List<dynamic>.from(subMenus!.map((x) => x)),
        "image": image,
      };
}
