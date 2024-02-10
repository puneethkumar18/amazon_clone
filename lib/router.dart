import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deal_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

import 'features/search/screens/search_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName :
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_)=>const AuthScreen(),
            );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  ProductDetailsScreen(product: product,),
      );
    case SearchScreen.routeName:
    var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  SearchScreen(
          searchQuery: searchQuery,
        ),
      );
      
    case CategoryDealsScreen.routeName:
    var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  CategoryDealsScreen(
          category: category,
        ),
      );
    case HomeScreen.routeName :
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const HomeScreen()
            );
    case BottomBar.routeName :
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const BottomBar()
            );

    default :
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text("Page not found 404!"),
              ),
          )
        );
  }
}