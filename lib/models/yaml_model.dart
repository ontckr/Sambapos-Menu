import 'menu_model.dart';

class YamlModel {
    YamlModel({
        this.menus,
    });

    List<Menu>? menus;

    factory YamlModel.fromJson(Map<String, dynamic> json) => YamlModel(
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menus": List<dynamic>.from(menus!.map((x) => x.toJson())),
    };
}