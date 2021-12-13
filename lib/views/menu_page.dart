import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sambapos_menu/models/item_model.dart';
import 'package:sambapos_menu/providers/menu_provider.dart';
import 'package:sambapos_menu/views/product_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _menuProvider = Provider.of<MenuProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          BasketButtonChip(basket: _menuProvider.basket),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductPage(
                          item: _menuProvider.discountMenuItems,
                        ),
                      ),
                    )
                  },
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(_menuProvider.discountMenuItems.image!),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.4),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        _menuProvider.discountMenuItems.name!,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 10 / 9,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _menuProvider.menuItems.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var item = _menuProvider.menuItems[index];
                      return InkWell(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ProductPage(item: item)),
                          )
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
            ),
          ],
        ),
      ),
    );
  }
}

class BasketButtonChip extends StatelessWidget {
  final List<Item> basket;
  const BasketButtonChip({
    Key? key,
    required this.basket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _menuProvider = Provider.of<MenuProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ActionChip(
        label: Text(
          basket.isEmpty ? "" : _menuProvider.basketPrice.toStringAsFixed(2) + "₺",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        avatar: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Icon(Icons.shopping_cart),
        ),
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              top: Radius.circular(18),
            )),
            context: context,
            builder: (_) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sepet",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: basket.isNotEmpty
                      ? ListView.builder(
                          itemCount: basket.length,
                          itemBuilder: (_, index) {
                            var item = basket[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  item.name == null ? item.caption! : item.name!,
                                ),
                                leading: Image(
                                  image: AssetImage(item.image!),
                                ),
                                trailing: Text(item.price?.toStringAsFixed(2) ?? ""),
                              ),
                            );
                          })
                      : Text('bos'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Toplam Tutar: " + _menuProvider.basketPrice.toStringAsFixed(2) + "₺",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
