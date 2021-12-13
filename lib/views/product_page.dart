import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sambapos_menu/models/item_model.dart';
import 'package:sambapos_menu/models/menu_model.dart';
import 'package:sambapos_menu/providers/menu_provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late MenuProvider _menuProvider;
  late List<Menu> subMenus;

  @override
  void initState() {
    super.initState();
    _menuProvider = Provider.of<MenuProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.item.name}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 10 / 9,
              crossAxisSpacing: 10,
            ),
            itemCount: widget.item.items?.length,
            itemBuilder: (BuildContext ctx, index) {
              var item = widget.item.items![index];
              return InkWell(
                onTap: () => {
                  if (item.subMenus == null)
                    {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                            top: Radius.circular(18),
                          )),
                          builder: (_) => SingleItemBottomSheet(item: item))
                    }
                  else
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      )),
                      builder: (_) => MenuBottomSheet(
                        subMenu: _menuProvider.getSubMenu(item.subMenus!),
                        item: item,
                      ),
                    ),
                  _menuProvider.selectMenu(item),
                },
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          child: Image(
                            image: AssetImage(
                              "${item.image}",
                            ),
                            width: 200,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        verticalDirection: VerticalDirection.up,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.black.withOpacity(.7),
                              child: Text(
                                "${item.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class SingleItemBottomSheet extends StatelessWidget {
  const SingleItemBottomSheet({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    var _menuProvider = Provider.of<MenuProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "${item.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("${item.image}"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item.price.toString()}₺",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    "Sepete Ekle",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    _menuProvider.addToBasket(item);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("${item.name} sepete eklendi."),
                    ));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({
    Key? key,
    required this.subMenu,
    required this.item,
  }) : super(key: key);

  final List<Menu> subMenu;
  final Item item;

  @override
  Widget build(BuildContext context) {
    var _menuProvider = Provider.of<MenuProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "${item.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: subMenu.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "${subMenu[i].description}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: subMenu[i]
                          .items!
                          .map((e) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    _menuProvider.addToSelection(subMenu[i].key, e);
                                  },
                                  child: ListTile(
                                    title: Text(
                                      e.name == null ? e.caption! : e.name!,
                                    ),
                                    leading: Image(
                                      image: AssetImage(e.image!),
                                    ),
                                    trailing: Text(e.price?.toStringAsFixed(2) ?? ""),
                                    selected: _menuProvider.selectedSubMenuItems.values.contains(e),
                                    tileColor: _menuProvider.selectedSubMenuItems.values.contains(e)
                                        ? Colors.black26
                                        : Colors.transparent,
                                  ),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_menuProvider.updatedBasePrice.toStringAsFixed(2)}₺",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    "Sepete Ekle",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    bool check = _menuProvider.addSelectionsToBasket();
                    if (check) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 1000),
                        content: Text("${item.name} sepete eklendi."),
                      ));
                      Navigator.pop(context);
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: Text('Lütfen tüm kategorilerden seçiminizi yapın.'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Tamam"))
                              ],
                            );
                          });
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
