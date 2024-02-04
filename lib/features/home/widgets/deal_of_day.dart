import 'package:flutter/material.dart';

class Dealoftheday extends StatefulWidget {
  const Dealoftheday({super.key});

  @override
  State<Dealoftheday> createState() => _DealofthedayState();
}

class _DealofthedayState extends State<Dealoftheday> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: const Text(
            "Deal of the day",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Image.network(
          'https://images.unsplash.com/photo-1682685797886-79020b7462a4?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: const Text(
            '\$1700',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            "Puneeth kumar",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1565630916779-e303be97b6f5?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGFwcGxlJTIwbGFwdG9wfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzJ8fGFwcGxlJTIwbGFwdG9wfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                'https://images.unsplash.com/photo-1531771686035-25f47595c87a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGFwcGxlJTIwbGFwdG9wfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                'https://images.unsplash.com/photo-1612903351512-96acf84e5306?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGFwcGxlJTIwbGFwdG9wfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                'https://images.unsplash.com/photo-1565630916779-e303be97b6f5?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGFwcGxlJTIwbGFwdG9wfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            "See all deals",
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        )
      ],
    );
  }
}
