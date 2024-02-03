import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).user;
    return  Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariable.appBarGradient,
      ),
      padding: const EdgeInsets.only(bottom: 10,left: 10),
      child: Row(
        children: [
          RichText(
            text:  const TextSpan(
              text:"Hello, ",
              style:  TextStyle(
                fontSize: 22,
                color: Colors.black, 
              ),
              children: [
                TextSpan(
                  text: "Puneeth",
                  style:  TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  )
                )
              ]
          )),
        ],
      ),
    );
  }
}