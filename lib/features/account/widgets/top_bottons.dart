import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  const TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: (){}),
            AccountButton(text: "Turn Seller", onTap: (){})
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(text: "Logout", onTap: (){}),
            AccountButton(text: "Your Wishlist", onTap: (){})
          ],
        )
      ],
    );
  }
}