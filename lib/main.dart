import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sambapos_menu/providers/menu_provider.dart';
import 'package:sambapos_menu/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
