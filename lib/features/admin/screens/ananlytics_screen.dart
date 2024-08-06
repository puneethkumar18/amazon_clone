import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AnanlyticsScreen extends StatefulWidget {
  const AnanlyticsScreen({super.key});

  @override
  State<AnanlyticsScreen> createState() => _AnanlyticsScreenState();
}

class _AnanlyticsScreenState extends State<AnanlyticsScreen> {
  final AdminServices adminServices = AdminServices();

  int? totalSales;
  List<Sales>? sales;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earnings = await adminServices.getEarnings(context: context);
    totalSales = earnings['totalEarnings'];
    sales = earnings['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null || totalSales == null
        ? const Loader()
        : Column(
            children: [],
          );
  }
}
