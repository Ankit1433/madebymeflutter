import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/screens/splash_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../screens/cart_screen.dart';
import '../providers/orders.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/auth_screen.dart';
import 'providers/auth.dart';
import '../helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items,
            ),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
          )
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'MyShop',
                    theme: ThemeData(
                        pageTransitionsTheme: PageTransitionsTheme(builders: {
                          TargetPlatform.android: CustomPageTransitionBuilder(),
                          TargetPlatform.iOS: CustomPageTransitionBuilder(),
                        }),
                        fontFamily: 'Lato',
                        colorScheme:
                            ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                                .copyWith(secondary: Colors.deepOrange)),
                    home: auth.isAuth
                        ? ProductsOverviewScreen()
                        : FutureBuilder(
                            builder: (ctx, authResultSnapshot) =>
                                authResultSnapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? SplashScreen()
                                    : AuthScreen(),
                            future: auth.tryAutoLogin(),
                          ),
                    routes: {
                      ProdductDetailScreen.routeName: (ctx) =>
                          ProdductDetailScreen(),
                      CartScreen.routeName: (ctx) => CartScreen(),
                      OrdersScreen.routeName: (ctx) => OrdersScreen(),
                      UserProductsScreen.routeName: (ctx) =>
                          UserProductsScreen(),
                      EditProductScreen.routeName: (ctx) => EditProductScreen(),
                    })));
  }
}
