import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddAproductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddAproductScreen({super.key});

  @override
  State<AddAproductScreen> createState() => _AddAproductScreenState();
}

class _AddAproductScreenState extends State<AddAproductScreen> {
  String category = 'Mobiles';

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  List<File> selectedImages = [];

  final _addProductFormKey = GlobalKey<FormState>();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final adminservices = AdminServices();

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      selectedImages = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() &&
        selectedImages.isNotEmpty) {
      adminservices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: selectedImages,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              'Add Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    selectedImages.isNotEmpty
                        ? CarouselSlider(
                            items: selectedImages
                                .map(
                                  (path) => Builder(
                                    builder: (BuildContext context) {
                                      return Image.file(
                                        path,
                                        fit: BoxFit.cover,
                                        height: 150,
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              strokeCap: StrokeCap.round,
                              dashPattern: const [10, 4],
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Select Product Images',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      controller: productNameController,
                      text: 'Product Name',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: descriptionController,
                      text: 'Description',
                      maxLines: 7,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: priceController,
                      text: 'Price',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: quantityController,
                      text: 'Quantity',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: productCategories
                            .map(
                              (val) => DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              category = value!;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      text: 'Sell',
                      onTap: () {},
                    ),
                  ],
                ),
              )),
        ));
  }
}
