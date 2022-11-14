import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const MaterialColor kPrimaryColor = const MaterialColor(
    0xFF0c1945,
    const <int, Color>{
      50: const Color(0xFF0c192a),
      100: const Color(0xFF0c192a),
      200: const Color(0xFF0c192a),
      300: const Color(0xFF0c192a),
      400: const Color(0xFF0c192a),
      500: const Color(0xFF0c192a),
      600: const Color(0xFF0c192a),
      700: const Color(0xFF0c192a),
      800: const Color(0xFF0c192a),
      900: const Color(0xFF0c192a),
    },
  );
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              Products(), // use create method when u (instntiate or provide) an object
        ),
        ChangeNotifierProvider(
          create: (context) =>
              Cart(), // use create method when u (instntiate or provide) an object
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          backgroundColor: Colors.black,
          primarySwatch: kPrimaryColor,
          accentColor: Color.fromARGB(255, 187, 187, 187),
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
        },
      ),
    );
  }
}

/**
 * Steps to add a wide state managment
 * 1 - add your prodider in a folder (prodivers) 
 * 2 - wrap the root widget with this widget => ChangeNotifierProvider
 * 3 - on the listener widget you should use Provider.of<Products>(context)
 * */
