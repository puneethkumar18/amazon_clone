import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text, 
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap, 
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalVariable.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size(double.infinity,50),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      );
  }
}