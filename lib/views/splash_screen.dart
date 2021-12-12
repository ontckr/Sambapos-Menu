import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sambapos_menu/providers/menu_provider.dart';
import 'package:sambapos_menu/views/menu_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<MenuProvider>(context, listen: false).getMenus();
  }

  @override
  Widget build(BuildContext context) {
    var _menuProvider = Provider.of<MenuProvider>(context);

    return !_menuProvider.loading
        ? MenuPage()
        : Scaffold(
            body: Center(
              child: Container(
                height: 200,
                color: Colors.orange,
                child: Image.network("https://sambapos.com/wp-content/uploads/2016/10/logo.png"),
              ),
            ),
          );
  }
}
