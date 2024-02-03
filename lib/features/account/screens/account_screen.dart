import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/account/widgets/below_app_bar.dart';
import 'package:amazon_clone/features/account/widgets/orders.dart';
import 'package:amazon_clone/features/account/widgets/top_bottons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), 
        child: AppBar(
          flexibleSpace: Container(
            decoration: const  BoxDecoration(
              gradient: GlobalVariable.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                  ),
                ),
              Container(
                padding: const EdgeInsets.only(right: 15,left: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.search_outlined),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ),
      body: const Column(
        children: [
          BelowAppBar(),
          SizedBox(height: 10,),
          TopButton(),
          SizedBox(height: 20,),
          Orders(),
        ],
      ),
    );
  }
}