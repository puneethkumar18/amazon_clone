import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_deatails_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderScreen> {
  final AdminServices adminServices = AdminServices();

  List<Order>? orderList;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orderList = await adminServices.fetchAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? const Loader()
        : GridView.builder(
            itemCount: orderList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (constext, index) {
              final order = orderList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDeatailsScreen.routeName,
                    arguments: order,
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    productUrl: order.products[0].imageUrls[0],
                  ),
                ),
              );
            },
          );
  }
}
