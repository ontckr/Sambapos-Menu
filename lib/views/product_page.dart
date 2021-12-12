import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sambapos_menu/models/item_model.dart';
import 'package:sambapos_menu/providers/menu_provider.dart';

class ProductPage extends StatefulWidget {
  final Item item;

  const ProductPage({Key? key, required this.item}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late MenuProvider _menuProvider;

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
                  if (item.subMenus == null) {singleItem(context, item)} else menuItem(context, item)
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

  Future<dynamic> singleItem(BuildContext context, Item item) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(18),
      )),
      builder: (_) => Padding(
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
            // Image(image: AssetImage("${item.image}")),
            ElevatedButton(
              child: Text("Sepete Ekle"),
              onPressed: () {
                _menuProvider.addToBasket(item);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> menuItem(BuildContext context, Item item) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(18),
      )),
      builder: (_) => Padding(
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
            // Image(image: AssetImage("${item.image}")),
            ElevatedButton(
              child: Text("Sepete Ekle"),
              onPressed: () {
                _menuProvider.addToBasket(item);
              },
            )
          ],
        ),
      ),
    );
  }
}
