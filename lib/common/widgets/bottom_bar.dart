import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';


class BottomBar extends StatefulWidget {
  static const String routeName = '/home-bar';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;


  List<Widget> list = [
    const HomeScreen(),
    const AccountScreen(),
    const Scaffold(
      body: Center(child: Text("Cart")),
    )
  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: list[_page],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor:GlobalVariable.selectedNavBarColor,
          unselectedItemColor: GlobalVariable.unselectedNavBarColor,
          backgroundColor: GlobalVariable.backgroundColor,
          iconSize: 28,
          onTap: updatePage,
          items: [
            BottomNavigationBarItem(icon: 
            Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(top:BorderSide(
                  width: bottomBarBorderWidth,
                  color: _page == 0 ? 
                  GlobalVariable.selectedNavBarColor :
                  GlobalVariable.backgroundColor,
                 ),
                ),
              ),
              child:  Icon(
                 _page == 0 ?Icons.home:Icons.home_outlined
                ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(icon: 
            Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(top:BorderSide(
                  width: bottomBarBorderWidth,
                  color: _page == 1 ? 
                  GlobalVariable.selectedNavBarColor :
                  GlobalVariable.backgroundColor,
                ),),
              ),
              child:  Icon(
                _page == 1 ? Icons.person_2:Icons.person_2_outlined,
                ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: 
            Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(top:BorderSide(
                  width: bottomBarBorderWidth,
                  color: _page == 2 ? 
                  GlobalVariable.selectedNavBarColor :
                  GlobalVariable.backgroundColor,
                ),),
              ),
              child:  Badge(
                
                label:const  Text("2" , style: TextStyle(fontWeight: FontWeight.bold),),
                child: Icon(
                  _page == 2 ?Icons.shopping_cart : Icons.shopping_cart_outlined),
              ),
            ),
            label: "",
          ),
          ],
        ),
    );
  }
}